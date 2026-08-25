Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BD95C5DF97
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 12:46:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09E6110ECD5;
	Wed, 26 Aug 2026 12:46:22 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11020135.outbound.protection.outlook.com [52.101.46.135])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8DF010E199
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Aug 2026 19:39:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jG679D07BY2F+/W62WDG2hD0MYIFPvxQSaQZLTW84rk85ST54e1/HFHNuQVEWo4CRd8SNyoCW3iz8+vgX1mnj8kTXYnpfLg6LpHUrEVOoI9FNU6IqRXkCcY+RhTdWWKrwZPUExaEkgwmTSThQJRfWJBiMxaPGuQXrFiKiQ9WXnHy6u3zDNFs5LzWnpmE59DT1iGuyx8u5ka5SSPUQCNmonTmS7HjT9gn6rIwDd6GeX1aCUlQkelXm8DjT1VavoEGFb7wAvb9pzF5+MtdYzEgbtmZo8kYtlvcNA1MkTbRSrJ78lx1BFPdAdbjWof19Bj7V4qm4pQiY3miyXIjJUa4Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=75oc6sntzZds0eVT2wcrtdKdG6nl9qtT927KXU44DNI=;
 b=CJUOiGd7GE7Gn/R2hOfF/hg4raFszWOgk5egnjymkQ0OS+ujnan39H9cDEaTTNjwclkZXUmYFK+MG9V5kliE3jl6OHJojHx77y0TRXVzuwL1iBg4oQ6VSQZCajvXpeKlPAuwaX2hFGYs7srtD7j2A136t+9vqaltf6Wg4mrb0pniBLfd7dPHiWP/bMFSliSHWJg/tQa2wCyczI/MOsTsVp2ZRSnXcXQ1PbZvbqVoYCsGHbmdkwR6d1MqnFG2PKAGj52b7qDf9slXrRh//edmMHsU/XhfMRy3YYl/aZdgJWERqmKX9LrHZk/oGVW4weUg/FgbH+f9jumVOnavECUM8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wizardsound.com; dmarc=pass action=none
 header.from=wizardsound.com; dkim=pass header.d=wizardsound.com; arc=none
Received: from SN7PR03MB7259.namprd03.prod.outlook.com (2603:10b6:806:2dc::7)
 by LV9PR03MB8415.namprd03.prod.outlook.com (2603:10b6:408:365::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 19:39:50 +0000
Received: from SN7PR03MB7259.namprd03.prod.outlook.com
 ([fe80::3140:ecd4:274:d1d3]) by SN7PR03MB7259.namprd03.prod.outlook.com
 ([fe80::3140:ecd4:274:d1d3%5]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 19:39:49 +0000
From: "michael wizardsound.com" <michael@wizardsound.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Felix.Kuehling@amd.com" <Felix.Kuehling@amd.com>,
 "alexander.deucher@amd.com" <alexander.deucher@amd.com>,
 "christian.koenig@amd.com" <christian.koenig@amd.com>
Subject: gfx1100: KFD leaks process VRAM after CP fault during AQL queue
 abort; device unusable until reboot
Thread-Topic: gfx1100: KFD leaks process VRAM after CP fault during AQL queue
 abort; device unusable until reboot
Thread-Index: AQHdNMjO+G6VRJqsDUKze4cva8yGPg==
Date: Tue, 25 Aug 2026 19:39:48 +0000
Message-ID: <SN7PR03MB72594F097881FCD1633872C8A2AF2@SN7PR03MB7259.namprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wizardsound.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR03MB7259:EE_|LV9PR03MB8415:EE_
x-ms-office365-filtering-correlation-id: 5436c9b0-7c3a-43ab-0987-08df02e0a000
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|10067099003|18002099003|56012099006|38070700021;
x-microsoft-antispam-message-info: Xib941Yxe7vvSreREzpG1GKCDtNLb2h3+7YwopvWvrcqgxfgGtK1NDqAepJ8Yb9QmDWODXnQQqJJkdvyaEZtHDSNJY0qZBvfv84VAU9yc8nPwBHeddPQVuOTrq3nnBGVRJMoX2DCJzRXF8LwNsA1VJBc4YfLfFVjBy32S9GMiqw7KyOxm0zJq+Re73wQ1aezpfSshDShgj123wT/KjSDso7IHSEAGQYdnWgEGuxdRZaTZnHf/Z8Hk41G3VGOfz657+AOR7+Tpr4NPF0BxFhh+iSjKRkbvhbfp3JtZnXuj3OCRxhAp2YNLIiWJYu/aYs0PysmpXUSXcHszBI3RbVBiM15Hqdo68Xc/P/0N33BEXsB6zqQWauevklSDKdJ+1Y+L0eMqLcnppto66xfuRec85ke502pzM4Ua/hA4VUNtbWc4KmZf8aQy38FWnKKV8fORvs7lQgGVg38oVMColOdcRO9aQNJ1h56+oS17mU1Xf7CjStmmi/844jIIGGucpJU/8nTkDbyFl0htyTc1duqLbmVKuS7Ny1dGB4kzjLrNPvSEoU0ECahUjPpGpL1tZvBSdaLe7GowZY0R4DklO7/E9OOl3Sa3d9gqCIRnfT3dk+Se5G3Ev7qm4Pz688aypgCsafxRNPHPxsDO+RT8idQM4HVGHV/AAquWAlAoifSckLVKoz4MIhAFLEV/DXOdq8Bf+Ni4RQu7bnzRyFBVNuquJSa2pUrMTIDV2ScwWH2f5A=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR03MB7259.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10067099003)(18002099003)(56012099006)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?O7/mt9gh/AzaW/frOTml7jHs2c0+aabw4UC8vy+GaYL3+uoXPKyIhSKHVp?=
 =?iso-8859-1?Q?rA6hx5FBAPQNg/SHkpHLfEHsRK6HrPfr4oqCS5TDRglv4XXE/JPsXw5zcy?=
 =?iso-8859-1?Q?GForojyKGN9NNXb8yMqIrsiIYo81Vrk1j87nNXCKU7DMM0qjJOQqzzg6eL?=
 =?iso-8859-1?Q?1z5zTD7Kdhwn40N8XMhL94xVLijopAIrj6iImLL6lDVBlw8Q/OXzA4SvWS?=
 =?iso-8859-1?Q?lWHPAhRI4KiZn2c/lCR6QmcRuBMVQP5q8O61Q1BhLBAMd+Rg5ngVs0SyQy?=
 =?iso-8859-1?Q?PQh+L3HwF4ru+VaDMQxaSmDU8ip/JmsqsA13abAkW3reTJG4Sf9kWzF3M2?=
 =?iso-8859-1?Q?d3EQRrI/wj3YQlLK6TKvVVmLtHETQWtxmiVijwMD4JiRQsHq0Ms5AMkEHq?=
 =?iso-8859-1?Q?vhhchYYXc67I9V99rACdI2Z9kdeNzeY2SDikNPgzes9N6jKGBXaovts/W+?=
 =?iso-8859-1?Q?9I8plMVdBPsiZfXQJEUNMM9CU89PKtLtJP7VVMvUTZHLh/nSOZnIi9JRJl?=
 =?iso-8859-1?Q?TH4AvyRttD4T636DzCkG6Q/BbcOtjQzSNcpvK1zKJejdQyWuKl9i0JukaO?=
 =?iso-8859-1?Q?jafiy3htUWoSWhdDWkWrbcNdx5RAEtgnErnGpQvG3VFk8Ghe+tKr/GMlTh?=
 =?iso-8859-1?Q?hFd01iUZQNzYSoCmcDXLWJRXaUcXDJ5gQK8pKVRVpJ7Pm4gXaFR4NUbsS+?=
 =?iso-8859-1?Q?e6oho4E31G6S3E7wIV7jyzHUSUFF+1ZOXjVT7Vhct4ayBMIfeXq9nA8ACo?=
 =?iso-8859-1?Q?Bzmi9o0qi88zgx5sY+7+gC7pw9UO4giJ2mlluRj0q+F1srgz7IvzzDeHQ6?=
 =?iso-8859-1?Q?ySMk2Z38kdNQQ9igfsRBus9lcuQyLMQK0lyDeESB0WK2FsI9wIn1MgEd/Y?=
 =?iso-8859-1?Q?DyoiafkuzIfEjoT9iO/WpX9sje2+4TaXeGzxcF0Y05XPogCCMho/mr7s+G?=
 =?iso-8859-1?Q?CdQl9jqzAlywJjVPaR/Jp4XOpBovi3hiHhaVR+Wx+XpIon1pp2jWZ5ciXX?=
 =?iso-8859-1?Q?msNGxomT3rSlYGEocWVltiHAs4fdrdYcIuxONOaI4y5o4vHSWGwl/Jz17s?=
 =?iso-8859-1?Q?WUBV4hlZ83Gm6j39h/+xtzloQgFnIbI773RnfdJlowlZpUh4ntfvxbLTPi?=
 =?iso-8859-1?Q?bWUs9kr/fhVRM+5h5QZfglTT5riQXCkaK3NJwdsU8q7oY5oLuURKWJ52UV?=
 =?iso-8859-1?Q?n0m7rYbsamYBaPi0w+JIuwdswo0dq3Y7ciJXqAiGxk/ed4c1jLnpR53oa2?=
 =?iso-8859-1?Q?2kKzSgNdx8qmD2nszEFsM/BeK+Ixtn9TziaNWQi8dXa/QFPFuOQZa0scAg?=
 =?iso-8859-1?Q?lxw3EiqqWTX7fHNMucHxuKDN/1UVrSTwxsnf+mAKR+YCvJMwgHYAMJ20ti?=
 =?iso-8859-1?Q?76K1wwDa+GZVkKaV4S00wrd5t6RXdNfLj6vsico1q9TrOfaZyOErm+FL0B?=
 =?iso-8859-1?Q?SrMhYGByUso7hmHnE2xQe4Lig52cjaUkDHjJzmkorkc8r+kuKa2CH/1zhB?=
 =?iso-8859-1?Q?WkKq4r81kfTaulwEHnYzQs3QiqHjlUm7CDW+QKTpABN7xHvwqBQLj5uvFK?=
 =?iso-8859-1?Q?lvAvUAyVX0hE33W+cWNId2me2aTxN1oZ8rrSpx1PtTA6fFcvoBTobsEUU2?=
 =?iso-8859-1?Q?qg4feEZpb3kSCWtkTD9HKT0joEKS2qzjvCbKUv1LAqSAHlyH+lpb7CUEQz?=
 =?iso-8859-1?Q?lECtcNOHoZDB8SssjQzsqxpyV/iC1p/Xf3onV6H7TDlM0X6niO1qUX3RS/?=
 =?iso-8859-1?Q?bnBsWtUAX49n1u/aKFKWMGb5iB2xiu/qlMgAKAs/r+u/AC?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wizardsound.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR03MB7259.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5436c9b0-7c3a-43ab-0987-08df02e0a000
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2026 19:39:48.9588 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5627d53f-ea9a-41df-b182-98bb6a35cd7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AvnVnVCJ2NYeV5wpiBqraWXaNv67A7cRnyW1WdCKFWQYRdv37jRjP2TAwXZr/6uogIfTXNdvb/VWo/NX7U+rdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR03MB8415
X-Mailman-Approved-At: Wed, 26 Aug 2026 12:46:21 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi AMD,=0A=
=0A=
I submitted some findings and I wanted to send this over.=A0 I hope this he=
lps.=0A=
=0A=
On a 7900 XTX in a Proxmox host (kernel 6.14.8-2-pve, ROCm userspaces 7.2.x=
/7.14 in an LXC sharing the host kernel), a userspace bug (rocm-systems#100=
21; root cause filed as rocm-systems#10713, runtime fix proposed in rocm-sy=
stems PR #10714) can place a malformed packet on a user AQL queue. The CP r=
aises gfx_v11_0_bad_op_irq ("Illegal opcode in command stream") followed by=
 an HSA_STATUS_ERROR_INVALID_PACKET_FORMAT queue abort. After the process e=
xits, its /sys/class/kfd/kfd/proc/<pid> entry persists and ~25.7 GB VRAM st=
ays pinned. amdgpu mode1 reset succeeds but does not release it; unbind suc=
ceeds but re-probe fails with EEXIST on mem_info_preempt_used (stale sysfs =
child from the wedged teardown), and subsequent per-device remove/bind atte=
mpts leave D-state tasks in device_release_driver_internal / device_driver_=
attach. Only a reboot recovers the device. Clean SIGSEGV deaths of the same=
 workload never leak; it is specific to the CP-fault teardown. Full logs, t=
imelines, and a userspace reproducer chain available; patches and standalon=
e reproducers for the userspace side are at https://github.com/OhgurLabs/ro=
cm-hipgraph-fixes.=0A=
=0A=
Michael Levesque, MBA=
