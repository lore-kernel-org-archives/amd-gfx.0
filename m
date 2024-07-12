Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8695C2BD09
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jul 2024 06:50:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47CFD10EC17;
	Fri, 12 Jul 2024 06:50:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aK/D8RAS";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EF4510EC17
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jul 2024 06:50:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dVJfphFmmMO+azT0edFP0ZHVq1zcEsDliECLVNzqJhYAGYrEkHlbCNZo4sTbqgWdCEzULLFZrynR+9oBDctbn9UKzq/6e0/IMrA6n/Vnwbk9cTgQibUgL64UBhZk5uoTGiyFpLO3UZxQ2vBWNQKob9RtM7zb4bcuLUezt6Qg+yxeQf2DOs69YotqJPDTbvdaEP3lRYHwDGOnqqrpufYB3BIBMiIyot7M+CfjaNnQCDgcaJOR2ENyVocXn+M5ARIhgvPm3nTtO8/EA9u74nedJlWOUbToc9+Z9ZInC5GgYZZgQYwMsgLG7ZLrF86kj7rrygFc9zMjFvJvjUqFePM24A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7q2ukJRM9/zfTUNYF01zK+9Y+RJ/Gvr9YLOmR4iVcbw=;
 b=hZJJ1BFGO3Cf6sj0QAqxP0XArZzpuFneOYyQjp1RdUWhY7f3Py545cQboJmSKEFvS2FOB3BvcDTYBgmZeaZ9MxJjzc1nccl263ujc67+g9yeae+oOZ9a6IijOWR0KM3jtZO+5nKjrwZ5gjzfzQ9tZMCxcU6ZbnJGJ0VVY3dR4dB0rFhG8+7b8UESTy6x8TISifzhZ0PaahLfiQSsO5F26SsYWPgbWQ/ub3ToKrDnR704Nf5dkWbWXghLKRHWu+AGxSbXaFzjX9RsTnyf5cluHMR047qPiaSnnqS83MLCStXTJRtv15dAZG5g6oscXDuBeLw08DOILxHMx02qSKucXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7q2ukJRM9/zfTUNYF01zK+9Y+RJ/Gvr9YLOmR4iVcbw=;
 b=aK/D8RASvYYf6yXWBXo0sLWn73DnDKYTblSuISSlC33ELXAlwwzmz163Lfigu9zzXTkmEZ3AmXskK8hyTk+Jdvo+u8DSVyYGts4mPN3eCixei4D0L6mX/H3Gp3O8fPaq9NpmDCNiu/QnbMlB0ZTD5Agz8kT3cw0M5Rni9v3c+z0=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by LV2PR12MB5727.namprd12.prod.outlook.com (2603:10b6:408:17d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Fri, 12 Jul
 2024 06:50:02 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%6]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 06:50:02 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Li, Candice" <Candice.Li@amd.com>,
 "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>, "Yang, Stanley"
 <Stanley.Yang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: add mutex to protect ras shared memory
Thread-Topic: [PATCH] drm/amdgpu: add mutex to protect ras shared memory
Thread-Index: AQHax29z9IS8lmbmuUqb++wg6PvQw7Hc7yMggAAGJ4CAFcshgA==
Date: Fri, 12 Jul 2024 06:50:02 +0000
Message-ID: <BN9PR12MB5257BE6D34504F8EB9853BDFFCA62@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240626022001.1139403-1-YiPeng.Chai@amd.com>
 <BN9PR12MB525743E2957686C33851547AFCD02@BN9PR12MB5257.namprd12.prod.outlook.com>
 <CH2PR12MB4215C667B550C62A10881881FCD02@CH2PR12MB4215.namprd12.prod.outlook.com>
In-Reply-To: <CH2PR12MB4215C667B550C62A10881881FCD02@CH2PR12MB4215.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=66cd1c4c-c409-4098-a1ce-1c02a6aacb55;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-28T09:38:59Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|LV2PR12MB5727:EE_
x-ms-office365-filtering-correlation-id: 30f620f9-4372-4c65-8c72-08dca23edb1d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?BmsiXKeNLk2iQ/PzXdkguITbU2BaS7JO79jpwwgypz8qPcuHagT92OWcrE6q?=
 =?us-ascii?Q?Qcd0A+oTSJaY1exhf/AveLOkOsPqFnr2ZGXHjwjkDqqxcKDq/drQpC/edV8l?=
 =?us-ascii?Q?dy1MCgZ8GypUcXxe4Y0kf+OVxZlwWNJqJ9IwMX6+W695sqBRCw6vnhOmK3eC?=
 =?us-ascii?Q?RpGDpWsoJP0FhcbtH2t9f24LUCWxmZFBp0/PwY4ljMhdj3Kd0Fp0Va0c+RtA?=
 =?us-ascii?Q?RSXXCsEtaz+XH3O7tyJMThUQBVIMmtqf1LvKb8upKjm5isitovaTsTUElM5z?=
 =?us-ascii?Q?FfDll1kv0DZkmk/+VOS3GhNFs/+dhHoQj63zt/N967OWiZhrLhiCRvVdGgsQ?=
 =?us-ascii?Q?rB8o01Bkk3npGqbmSOUmtVXiHCK91oE1gvJSUrdEs3VT9zq26MrYzPsWUx3l?=
 =?us-ascii?Q?q0D+WMrI5Crjt9d3L9YSp6b60u2pjV7rP6k/0u4c+fS0ufLOJcrM3GPH8Ulf?=
 =?us-ascii?Q?/z/trC31RN7MwtndmDsqYo2xEeb45z5SDyz0olmAJviUj4SjldUljs9NO5rZ?=
 =?us-ascii?Q?mD0kAvQMJdOGwh+KEsre2tr6TCqykVIevL/l0TTeMkHQMHG1eUBbqLNzThl2?=
 =?us-ascii?Q?/pWO1JyUP8sswP2xPhdmDXnqIYyY//Mg0I1XRQJjOem9B9Qe+LHAZLtgyEs8?=
 =?us-ascii?Q?th7ppH7exJg+9doZqnbVdltcG+n8gKzv0/7/5Dd0WnTZ7bsQLn4Cd0Fzj+tx?=
 =?us-ascii?Q?p8+0m+UZ4/cvDE4PEmCc3a4twPPGMJO6heuI/mD+TjpcziN5iaKRkaUyX6Q9?=
 =?us-ascii?Q?1j+EfCaILmEon6kTsqbeeMjWZtHqyhdnFaAc8xyOL325FAeCE6MrVxM+kNVj?=
 =?us-ascii?Q?eTQZN4FRFsJmU4XIrdDsFcD0R3/IFf7bvFMSTbS5Fu6wo2iWxAq0RhZOFyoT?=
 =?us-ascii?Q?aZ9O5SSnr10VDWaPR+F3tWBDPa1ELDgl3ioavGZAEJwoL6cr86fVmSc2HNM+?=
 =?us-ascii?Q?3ZyQwuW9qq/ZDEJakoJwzqkgWLzeBZFHAz6UtmopZsWzqnGvglDhIgf6Tm6Y?=
 =?us-ascii?Q?nxj1gZIti9bNNejW0y4ejTVm0tBVmmlOYn+c+vB9BvOd8W3Zyiv80l4dELQk?=
 =?us-ascii?Q?nmDyig5Wi2obzKdquNHpVcK+PaIr9x6fFHlnL+AfWCkqzEoWVMhFe6zO2/F9?=
 =?us-ascii?Q?pm/mvlwehCHiCktf9Q8H/Ok226A70rDrUxCM6FMN3wviPrTNZYe6yf+GT5Ji?=
 =?us-ascii?Q?CGzo5X9Fzo2vPsNLAIHsol6dfAhp8NgIaP3ytMJTwB+6/evSHwTqVY4n0Gfn?=
 =?us-ascii?Q?y1e0TP+Pv9xaMz36iPwtuH+fvdJKgnhQqhSzbMXydha7e8Rdaj7lRx9QKoR3?=
 =?us-ascii?Q?8iI2+P+To50tof/lsacMt0sNtVyrFpDyRmQqEn1hNj/MpEqpCy310HZApiOz?=
 =?us-ascii?Q?qp6wFUZHLpyzFZ02I6XnUi2xnk6jRzTRWv3c36j9huIViAXANg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zupJyedcWYotc0qw4jkmqp6InH5U3pTUgPlgubLejBL2m1JrKIEhj2Oj/nBs?=
 =?us-ascii?Q?2EFpnWc98rJjnt2zTnWDBpSM9W4br8xOQ9msnZ2QYIjSfdOXjB/+1k0zpvst?=
 =?us-ascii?Q?ywOaAuZcaE7sniylXzmhqJKbNCG3F8zUGk/WKL0ShRCDRlybm5EhqUZNtT++?=
 =?us-ascii?Q?+4MQIV+BOQnf4bq9Hnq4QFbpVErBA1cgGxhnVELVtIfs/KFuei00p513DWj8?=
 =?us-ascii?Q?xIVX21nrYeRx+4tMA/kj91YHTI/rsrXzIBDwXQmgcZ6PIT5H1orGG+YMtOMw?=
 =?us-ascii?Q?6nglNSc0PuzmeZGckXZ1gTJhlCs250ZgyZHEQ6ZhLwTxliOF2n9xXoz+6fDa?=
 =?us-ascii?Q?Ha2PWh2Zl+AEh7FIi85hXSlL8rcWQaUiKBb3i/Pt6ARTignuq+jBNsr7Fkun?=
 =?us-ascii?Q?JC2ZHBCWstAMvYzMN7H/PdZuY0//PldaXxPh7FoPoAyP2oWJms25PE/HeFHs?=
 =?us-ascii?Q?Wia/iPpPnQJpJrMKqfYKOxBpYbJqXCbkwQlwxeJfyZFCNaDnsQpL3vtaHJbu?=
 =?us-ascii?Q?7wjq0K5rvcLClwxUvhPI2Ez9l13WdLi0Ym7V3miAkaTlJiWJygMjxilOE9Nf?=
 =?us-ascii?Q?kny2XRR9BK2wjkGrz7U/6wOnZyJclZQ05UnVrZ1ZZSPKjyUWaN0wkdAStl8U?=
 =?us-ascii?Q?kNIzFV2hDEgNYPfxjRqgBPSB9Zqsj3vnKzs60GMgob5A+AKMXAgg4noEQXwf?=
 =?us-ascii?Q?RyftokyTpvTB9QcSyfrTg9Z8VmusFRkXQjDrZYHrmPWgFqo+/FluZKYeE8Uf?=
 =?us-ascii?Q?EWSsAoHVNw3hU6mp2jYY2TZBBLpmOeWhqRTfRhWUnbbUlJc+EvFDBbhWKZcC?=
 =?us-ascii?Q?X0jvR9hFc2TbE7wdNCuioo+Y2eygRNOwaqCzSr50ozFew+UW0rih6fAbZqA/?=
 =?us-ascii?Q?6zVnWGhnYlXK1zSgg/YTZagZhFYYuXtnstr4BEKve8bSbOIBBN2iEQ1pFap+?=
 =?us-ascii?Q?u9YLdWoRkTdBhlIr3AzgLs8FtwWTsceAL0WPILzc9c8eyn1i2pv7jmMEngzm?=
 =?us-ascii?Q?SLaWfGH82gWYnk/BhCcrbgUVXL+N+9UPbl8daxIRtPsSVdPV9qAFLgEQsQV7?=
 =?us-ascii?Q?Fy84eDHXaSb0j2ljCOQpoXDK01NrNo88q7A0usCHF7slXV6Hokws3kOax+je?=
 =?us-ascii?Q?o2yiBC8+wsMMnvNB6C6kpkUH/WaO9nt9vXz9urWZLUWnJ3a/IfWwU3Pdvask?=
 =?us-ascii?Q?Cg4uIxkz37neakNARUQ7qsULkpv67Obg8DPrzYfS0NFjWf6zkH916vllbYrX?=
 =?us-ascii?Q?M14ASQhx4YsQmZI4tYE9M//7vOatViBgONWywiVR0mMwOt6pBfDgL+5yPltl?=
 =?us-ascii?Q?J7A0YeRwFH5VPWlBL6r6eY7nXpq/wU3h+hhoJemVIGnvu1+pBKxEjEjuiLx8?=
 =?us-ascii?Q?L2sqgrVY/yaUMDuBYo9Kdm/0q84SeiJ69cwWPesen8llIDBYhdv+OI8VwRCK?=
 =?us-ascii?Q?Gc7AJaAc7jKAsah46yZVyDybYT7/+B5QSTxCeA2jXmY4JOS1OjHhmdIXfU3c?=
 =?us-ascii?Q?SWIh7GmJRVkGm2tUtKZx2mMu7NLMcrNKcK6x4HHq6alVLalWEX6jT6rVsLPG?=
 =?us-ascii?Q?OE69qkc8T96ZWron5vnLlT7bo7HqAHVe48LRIna5?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30f620f9-4372-4c65-8c72-08dca23edb1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2024 06:50:02.7554 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: StXXNYPCmZqWyhLbjUPJASVQZJrPgES12a8I3tqI3jti4J8ck+KtzrWY6STmqP4Irqci4khmZJbQQrMByyGBmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5727
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

[AMD Official Use Only - AMD Internal Distribution Only]

BTW, can we consider leveraging psp->mutext to protect both shared memory a=
nd command submission?

Regards,
Hawking

-----Original Message-----
From: Chai, Thomas <YiPeng.Chai@amd.com>
Sent: Friday, June 28, 2024 18:01
To: Zhang, Hawking <Hawking.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Li, Candice <Candice.Li@amd.com>; Wang,=
 Yang(Kevin) <KevinYang.Wang@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: add mutex to protect ras shared memory

[AMD Official Use Only - AMD Internal Distribution Only]

OK


-----------------
Best Regards,
Thomas

-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com>
Sent: Friday, June 28, 2024 5:42 PM
To: Chai, Thomas <YiPeng.Chai@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Li, Candice <Candice.Li@amd.com>; Wang,=
 Yang(Kevin) <KevinYang.Wang@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>=
; Chai, Thomas <YiPeng.Chai@amd.com>
Subject: RE: [PATCH] drm/amdgpu: add mutex to protect ras shared memory

[AMD Official Use Only - AMD Internal Distribution Only]

+       ret =3D psp_ras_invoke(psp, ras_cmd->cmd_id);

+       case TA_RAS_COMMAND__TRIGGER_ERROR:
+               if (out) {
+                       uint32_t *ras_status =3D (uint32_t *)out;
+
+                       *ras_status =3D ras_cmd->ras_status;
+               }
+               break;
+       case TA_RAS_COMMAND__QUERY_ADDRESS:
+               if (ret || ras_cmd->ras_status || psp->cmd_buf_mem->resp.st=
atus)
+                       ret =3D -EINVAL;

Shall we make the following check for both TRIGGER_ERROR and QUERY_ADDRESS =
command?

+               if (ret || ras_cmd->ras_status || psp->cmd_buf_mem->resp.st=
atus)
+                       ret =3D -EINVAL;

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of YiPeng C=
hai
Sent: Wednesday, June 26, 2024 10:20
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Li, Candice <Candice.Li@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.co=
m>; Yang, Stanley <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com=
>
Subject: [PATCH] drm/amdgpu: add mutex to protect ras shared memory

Add mutex to protect ras shared memory.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    | 124 ++++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h    |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c |   2 +
 3 files changed, 87 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index fec968d8340f..323b3c470c5c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1573,6 +1573,69 @@ static void psp_ras_ta_check_status(struct psp_conte=
xt *psp)
        }
 }

+static int psp_ras_send_cmd(struct psp_context *psp,
+               enum ras_command cmd_id, void *in, void *out) {
+       struct ta_ras_shared_memory *ras_cmd;
+       uint32_t cmd =3D cmd_id;
+       int ret =3D 0;
+
+       if (!in)
+               return -EINVAL;
+
+       mutex_lock(&psp->ras_context.mutex);
+       ras_cmd =3D (struct ta_ras_shared_memory *)psp->ras_context.context=
.mem_context.shared_buf;
+       memset(ras_cmd, 0, sizeof(struct ta_ras_shared_memory));
+
+       switch (cmd) {
+       case TA_RAS_COMMAND__ENABLE_FEATURES:
+       case TA_RAS_COMMAND__DISABLE_FEATURES:
+               memcpy(&ras_cmd->ras_in_message,
+                       in, sizeof(ras_cmd->ras_in_message));
+               break;
+       case TA_RAS_COMMAND__TRIGGER_ERROR:
+               memcpy(&ras_cmd->ras_in_message.trigger_error,
+                       in, sizeof(ras_cmd->ras_in_message.trigger_error));
+               break;
+       case TA_RAS_COMMAND__QUERY_ADDRESS:
+               memcpy(&ras_cmd->ras_in_message.address,
+                       in, sizeof(ras_cmd->ras_in_message.address));
+               break;
+       default:
+               dev_err(psp->adev->dev, "Invalid ras cmd id: %u\n", cmd);
+               ret =3D -EINVAL;
+               goto err_out;
+       }
+
+       ras_cmd->cmd_id =3D cmd;
+       ret =3D psp_ras_invoke(psp, ras_cmd->cmd_id);
+
+       switch (cmd) {
+       case TA_RAS_COMMAND__TRIGGER_ERROR:
+               if (out) {
+                       uint32_t *ras_status =3D (uint32_t *)out;
+
+                       *ras_status =3D ras_cmd->ras_status;
+               }
+               break;
+       case TA_RAS_COMMAND__QUERY_ADDRESS:
+               if (ret || ras_cmd->ras_status || psp->cmd_buf_mem->resp.st=
atus)
+                       ret =3D -EINVAL;
+               else if (out)
+                       memcpy(out,
+                               &ras_cmd->ras_out_message.address,
+                               sizeof(ras_cmd->ras_out_message.address));
+               break;
+       default:
+               break;
+       }
+
+err_out:
+       mutex_unlock(&psp->ras_context.mutex);
+
+       return ret;
+}
+
 int psp_ras_invoke(struct psp_context *psp, uint32_t ta_cmd_id)  {
        struct ta_ras_shared_memory *ras_cmd; @@ -1614,23 +1677,15 @@ int p=
sp_ras_invoke(struct psp_context *psp, uint32_t ta_cmd_id)  int psp_ras_ena=
ble_features(struct psp_context *psp,
                union ta_ras_cmd_input *info, bool enable)  {
-       struct ta_ras_shared_memory *ras_cmd;
+       enum ras_command cmd_id;
        int ret;

-       if (!psp->ras_context.context.initialized)
+       if (!psp->ras_context.context.initialized || !info)
                return -EINVAL;

-       ras_cmd =3D (struct ta_ras_shared_memory *)psp->ras_context.context=
.mem_context.shared_buf;
-       memset(ras_cmd, 0, sizeof(struct ta_ras_shared_memory));
-
-       if (enable)
-               ras_cmd->cmd_id =3D TA_RAS_COMMAND__ENABLE_FEATURES;
-       else
-               ras_cmd->cmd_id =3D TA_RAS_COMMAND__DISABLE_FEATURES;
-
-       ras_cmd->ras_in_message =3D *info;
-
-       ret =3D psp_ras_invoke(psp, ras_cmd->cmd_id);
+       cmd_id =3D enable ?
+               TA_RAS_COMMAND__ENABLE_FEATURES : TA_RAS_COMMAND__DISABLE_F=
EATURES;
+       ret =3D psp_ras_send_cmd(psp, cmd_id, info, NULL);
        if (ret)
                return -EINVAL;

@@ -1654,6 +1709,8 @@ int psp_ras_terminate(struct psp_context *psp)

        psp->ras_context.context.initialized =3D false;

+       mutex_destroy(&psp->ras_context.mutex);
+
        return ret;
 }

@@ -1738,9 +1795,10 @@ int psp_ras_initialize(struct psp_context *psp)

        ret =3D psp_ta_load(psp, &psp->ras_context.context);

-       if (!ret && !ras_cmd->ras_status)
+       if (!ret && !ras_cmd->ras_status) {
                psp->ras_context.context.initialized =3D true;
-       else {
+               mutex_init(&psp->ras_context.mutex);
+       } else {
                if (ras_cmd->ras_status)
                        dev_warn(adev->dev, "RAS Init Status: 0x%X\n", ras_=
cmd->ras_status);

@@ -1754,12 +1812,12 @@ int psp_ras_initialize(struct psp_context *psp)  in=
t psp_ras_trigger_error(struct psp_context *psp,
                          struct ta_ras_trigger_error_input *info, uint32_t=
 instance_mask)  {
-       struct ta_ras_shared_memory *ras_cmd;
        struct amdgpu_device *adev =3D psp->adev;
        int ret;
        uint32_t dev_mask;
+       uint32_t ras_status;

-       if (!psp->ras_context.context.initialized)
+       if (!psp->ras_context.context.initialized || !info)
                return -EINVAL;

        switch (info->block_id) {
@@ -1783,13 +1841,8 @@ int psp_ras_trigger_error(struct psp_context *psp,
        dev_mask &=3D AMDGPU_RAS_INST_MASK;
        info->sub_block_index |=3D dev_mask;

-       ras_cmd =3D (struct ta_ras_shared_memory *)psp->ras_context.context=
.mem_context.shared_buf;
-       memset(ras_cmd, 0, sizeof(struct ta_ras_shared_memory));
-
-       ras_cmd->cmd_id =3D TA_RAS_COMMAND__TRIGGER_ERROR;
-       ras_cmd->ras_in_message.trigger_error =3D *info;
-
-       ret =3D psp_ras_invoke(psp, ras_cmd->cmd_id);
+       ret =3D psp_ras_send_cmd(psp,
+                       TA_RAS_COMMAND__TRIGGER_ERROR, info,
+ &ras_status);
        if (ret)
                return -EINVAL;

@@ -1799,9 +1852,9 @@ int psp_ras_trigger_error(struct psp_context *psp,
        if (amdgpu_ras_intr_triggered())
                return 0;

-       if (ras_cmd->ras_status =3D=3D TA_RAS_STATUS__TEE_ERROR_ACCESS_DENI=
ED)
+       if (ras_status =3D=3D TA_RAS_STATUS__TEE_ERROR_ACCESS_DENIED)
                return -EACCES;
-       else if (ras_cmd->ras_status)
+       else if (ras_status)
                return -EINVAL;

        return 0;
@@ -1811,25 +1864,16 @@ int psp_ras_query_address(struct psp_context *psp,
                          struct ta_ras_query_address_input *addr_in,
                          struct ta_ras_query_address_output *addr_out)  {
-       struct ta_ras_shared_memory *ras_cmd;
        int ret;

-       if (!psp->ras_context.context.initialized)
-               return -EINVAL;
-
-       ras_cmd =3D (struct ta_ras_shared_memory *)psp->ras_context.context=
.mem_context.shared_buf;
-       memset(ras_cmd, 0, sizeof(struct ta_ras_shared_memory));
-
-       ras_cmd->cmd_id =3D TA_RAS_COMMAND__QUERY_ADDRESS;
-       ras_cmd->ras_in_message.address =3D *addr_in;
-
-       ret =3D psp_ras_invoke(psp, ras_cmd->cmd_id);
-       if (ret || ras_cmd->ras_status || psp->cmd_buf_mem->resp.status)
+       if (!psp->ras_context.context.initialized ||
+               !addr_in || !addr_out)
                return -EINVAL;

-       *addr_out =3D ras_cmd->ras_out_message.address;
+       ret =3D psp_ras_send_cmd(psp,
+                       TA_RAS_COMMAND__QUERY_ADDRESS, addr_in,
+ addr_out);

-       return 0;
+       return ret;
 }
 // ras end

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.h
index 3635303e6548..74a96516c913 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -200,6 +200,7 @@ struct psp_xgmi_context {  struct psp_ras_context {
        struct ta_context               context;
        struct amdgpu_ras               *ras;
+       struct mutex                    mutex;
 };

 #define MEM_TRAIN_SYSTEM_SIGNATURE             0x54534942
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_psp_ta.c
index 8e8afbd237bc..0c856005df6b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
@@ -348,6 +348,7 @@ static ssize_t ta_if_invoke_debugfs_write(struct file *=
fp, const char *buf, size

        context->session_id =3D ta_id;

+       mutex_lock(&psp->ras_context.mutex);
        ret =3D prep_ta_mem_context(&context->mem_context, shared_buf, shar=
ed_buf_len);
        if (ret)
                goto err_free_shared_buf; @@ -366,6 +367,7 @@ static ssize_=
t ta_if_invoke_debugfs_write(struct file *fp, const char *buf, size
                ret =3D -EFAULT;

 err_free_shared_buf:
+       mutex_unlock(&psp->ras_context.mutex);
        kfree(shared_buf);

        return ret;
--
2.34.1



