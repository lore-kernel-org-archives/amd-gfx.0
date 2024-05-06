Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17768C25B5C
	for <amd-gfx@archiver.kernel.org>; Mon,  6 May 2024 09:20:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2A0910EEF3;
	Mon,  6 May 2024 09:20:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L2ayvQEl";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2064.outbound.protection.outlook.com [40.107.100.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10F7D10EEF3
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 May 2024 09:20:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hIL5KPslXhRadJHabFWZ1jKOBuGPC9gQ7g951UtlGQnz+wml0A6cX/IIVYFEXhoP8aL0B9ffxA7qMiSTBhrooYEW/l3OQmyXIbgK0G9wZVBhh2IT2ecB6xkl7spzRPGlrW305YP3LzrLTn9qbsdOlgqDCEHtXjapyJPW63I+CLHaVmVkoVtGGM50jXPDFAeSWB27BKpn2fHAFgoYRL9bq5pT5hk9sRelPPsChhyoNQ1sBMTIxqb5kS0Jsq0kgowSQZsclI2x1N7jgXSNPDAs2p0zuZGzyeTKu0UnDGfGqk5/tcbx9BAUw67OabMovFnQhc9tHyLRfCTQ4DnYWjRBfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EcfNFpEktdTMALNUmU4bgHw+4jPZ4M4V7FqnGdSqrDE=;
 b=e+8d3pEhVToFTslz1bnqEAZszSkRttJ6noaLjtQPs8ve9x18LgE1zR4imyEeZdd26fpvHPI6H9eKHZiO7k2CCj1dEa/1Esv57LXh9ja890yt3ErCaTw/YKyE+rAYBhi2PHnnWoT4U8fAUaKJLFfgAJs9ORJlhr2biFJSBjRPczcW9drvJVdyVIulxlANeJg3KE4KZB6KjFhminltnBkdHNBK6wXZpfwD3M5b/dpopyFK8m3vRjsM40PLaeGluV6XXAgSud8VzZEB19VeoRO+jNcJnKMYtfz1gSXHedcvEKBKmFbFScO4Rfm6IbOYaSp2y5EFCU4fMRxWxqUZJHR/YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EcfNFpEktdTMALNUmU4bgHw+4jPZ4M4V7FqnGdSqrDE=;
 b=L2ayvQElEKLVEUdpYsV38wiC7Vwhvuulz8/t2IHXKBgjpQHpz1yMQiO2QZohj74DgR/GJPEu9WPQYX+uK0+u9qAEyRlohf/KecAUODyHHvei7tVPy1TnIVhhJPPsqVVRbkosTnSTgQP4JSdskhM66TVTtlsPAJuDG0gsdrfLEpI=
Received: from CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 by SA1PR12MB7173.namprd12.prod.outlook.com (2603:10b6:806:2b4::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30; Mon, 6 May
 2024 09:20:16 +0000
Received: from CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9]) by CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9%4]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 09:20:15 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Ma, Jun" <Jun.Ma2@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
CC: "Ma, Jun" <Jun.Ma2@amd.com>
Subject: RE: [PATCH v2] drm/amdgpu: Fix out-of-bounds write warning
Thread-Topic: [PATCH v2] drm/amdgpu: Fix out-of-bounds write warning
Thread-Index: AQHan3qZoNUC0NXDrUaVh1LYUpV0U7GJ7Yzg
Date: Mon, 6 May 2024 09:20:15 +0000
Message-ID: <CH3PR12MB8074E2E5AB92F36445B3776BF61C2@CH3PR12MB8074.namprd12.prod.outlook.com>
References: <20240506055901.227249-1-Jun.Ma2@amd.com>
In-Reply-To: <20240506055901.227249-1-Jun.Ma2@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=630a3388-e765-4992-b15c-a9a6d8c41760;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-05-06T09:18:00Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8074:EE_|SA1PR12MB7173:EE_
x-ms-office365-filtering-correlation-id: 7b781448-f1fe-4006-0e81-08dc6dadbd9b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?ZVdyVmxadGNlWDVLczZsMExaS1dGN2phUjB0bmJzMVlIa2s5M3VVM0ZuaVZT?=
 =?utf-8?B?VURVaDFiYWZpeFRFc01zZEE2WUY0cWFFRXdPTDJSd3lsU3R6QjdnNFhyT2RZ?=
 =?utf-8?B?dHplZkFFaTl5TzZXR2ViZ3AzdnhrbWFUZGVNNmJ5L1VERlRhZEg1ek1RM2FC?=
 =?utf-8?B?K2xUbWFsMVgzYXFZS0wvaHh2Q25LNDdMeXhzZm9kTWtXd0dqeC9nREtCQS9W?=
 =?utf-8?B?Z0lwNHdDVzJyVW1oRmI1cStQdDRDQzJsOFRNbjQvalFkYlRZd1BsNnVZa3Bh?=
 =?utf-8?B?SXlBQjBKMG9yd2YvVURRb2NRdnNKQ3hHQkYzY2VuZzJWYzdjU0VaQ0R6VmpV?=
 =?utf-8?B?WjcrWkNtMjEvRWRMMy9sWGRyWUVuK3VMTmNIbkVaalppUHQzOFZ5SS8xU3Ez?=
 =?utf-8?B?MzZ6TmdMNllLS0ZEa0tIQ1lYUkt1TGw1NmJabFg5WE1MTS80RktDTk9NZjZU?=
 =?utf-8?B?WWxITWJuOGN2bTQ4dlRWT25uYU9oOHZFa2dabnpuT2ZkblgvR2F1ZjVCdEdV?=
 =?utf-8?B?TnBNR3FJMXpoR2Ric0ZjMHJTR3ZtSmFXbXQ3QUxnblJlNUhPN1NnSHhqZXNN?=
 =?utf-8?B?L2NaUGFGYUlhRk5PZU8vSVl4UzJaL3d3MUwyLzFqRnNuQzljQ3VqYVJ2NzM4?=
 =?utf-8?B?dzdka0hTU0tTTngzak9pZ05hVjRnNFVmV2h0UUR5VHJ3aTNLL2t5K3FTeDdl?=
 =?utf-8?B?NXM2ODVuWExpS2RYYnNKZzNKRVhkRU1FQndraTlWd1dPeEJ5QUtCTnI1eS9x?=
 =?utf-8?B?ZlNIVi9jUlEzeU5ZS1BmdVIzR3RUbXd6K1gySnV2MWVZRU50MFVlT0JlQVZQ?=
 =?utf-8?B?dHBIRWhQd2duRkxYcEFRZFc1QU9zazU4RzJaUlNGay9WKzNKUTFjV01RdzNZ?=
 =?utf-8?B?MXVMcVEvbUFHcnoxVklHWllnUTJVd1J4NjErTjhyZmVKZXFSQUtZOGI2NG1Q?=
 =?utf-8?B?c2RYL0UyY1RZd0N2b2RjaDRQV2ZIWWswdVRXWTArOFJ3aFk4OU9Hb1k0S1VR?=
 =?utf-8?B?dms1d3d6eW5CcUMrbEhNMXl1SjZxTTRoYU9kS040REIzdS9QSlJWMkJOZGR2?=
 =?utf-8?B?S3dhNHdHeFlucXd1YkorV2FQc2JwbDhmcGR1TjNSL3J1WWx0QjhSbG5zRzZz?=
 =?utf-8?B?NU84bzVwSTVtOVZIaE1HVzVXZnFaa0NsZGxFNXA2cWl5MDVvUnNkVWtVOGZk?=
 =?utf-8?B?VlBOOFNKbUlJaGxuYmUwakxHMWRLVU1ySCt6c1lPbGFVUG1lWVJHTFl5Y29G?=
 =?utf-8?B?T3hHbk42RTNTMTllQTFwdlJXb0JlR0c0YytQWjJmTnp1c3dMeWJ2QzBSUmMw?=
 =?utf-8?B?eVNzWTJ6bDJIY2I0RE52WWhmVWZVVHdGOTZqUlA1VVY0UlR4MXRrMlJXd0NX?=
 =?utf-8?B?R2Z2VHNYL0NNRXpnckt0elV5QlQrUHYwdjJQUkIrM3dUTVkxeHRNYk9vLzNX?=
 =?utf-8?B?cUlRL1ZML0pYUkxWSzlwZHFaOUVsaURYZ1FYSDJFZi9kMkFBS2ZpRXd3VlY3?=
 =?utf-8?B?amU1Z1RWZGhaTHZSeHlyWU9Ba0orSDQ3US9ibWQ5ZVZJYlFXUE5aU3dTaTN1?=
 =?utf-8?B?cmptYVhjL2d1VlhKZnJYeTZmUDJUYXRnelloVnVqTi8vU3hTeldPUlJBNHp0?=
 =?utf-8?B?bTUwNmdiM2NMSlhWZjZiVkdvZ1prc0V3bXQyQzJoaGJFeUFQYzJmUG9PeGxJ?=
 =?utf-8?B?djlTNTlrblJBdFlDQlhNT3Y0aHRWaHkyRG43VjY4cGhGc0JWN3pzR2YrdEhE?=
 =?utf-8?Q?IBYAcsGq+0Xwx8zbxPW32GCq+2xOUv1Ob90GRSW?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8074.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UjNxbXZCalZlaWc3S3FERXBwcXo1ZytIVGhxdmxEc3NXVXNqanUyNFByUVcw?=
 =?utf-8?B?elh4R2FiQ0hFbzE4b0tsYzRHRHh1WEdiMHllTVhMeUZOVWVHVENPR0swZFFX?=
 =?utf-8?B?YmYvK0wxays3dk11RGNxRlM0Sk9aanVrVWFuaGx1L1NZK1ErMFpDV1prbENv?=
 =?utf-8?B?TE9vcjE5am5Ub2s1THpDUEgyL21Rc21XZTh3MStjNzlyTjZHYzgzMHFLOWEv?=
 =?utf-8?B?ZjRoOVJ6MkR6Wm5XQ0RWV1poVWxMeXZJbktxUEdBdXhvb3p2a01wMHY3N2RX?=
 =?utf-8?B?RVNMd2c0bWJGZU1acDN1RmRHTms3bDRLYzBMaVZYRG13ejhjOWVyMUU2MTJ4?=
 =?utf-8?B?WU9iUGQ3OUpYcjU4QU03eVBLNjhndWxoWXNkNkR5VjV1OEl1ZEY2YjhOS2Mv?=
 =?utf-8?B?WDAwS20vdzVsY0E0OFgzSmZQcUp4QVRxRmp2aHh1TjVYbzl0RjRiandSRmhY?=
 =?utf-8?B?VDZIOE94K3VIMDM2QUpMYmNyUURPL2xNR05KWEM3Q1k2RHRPYk54T0ptODEw?=
 =?utf-8?B?Y2NZbGorVTNtcGlqZGEyNFlLNG1RTU9MekFKNEpRUXdKcnNvZ2FVODFzTHQz?=
 =?utf-8?B?Y2pqQ2JWeURNVGFKZDJkOG45L3pkRlg2dE5oazJ5T1pIbkhOLzNxaVZ1YmJZ?=
 =?utf-8?B?YnFQQmdHbE1RZFhOZTViNWFBRXBCY3ZYMlFFZVFHQjJxd1RqM0loNkNXbnd3?=
 =?utf-8?B?TS9PamFITnh4UWZZa3c1ZUY0RXhOMS9WYUpYOGtaeUZyQVB5d3JPeUVCaGla?=
 =?utf-8?B?UzBCMmVGSlRPbnVScEpuZEo2cGFZcGEzUUVQSU9ZKzBCUHdTN3g4UTJpNXl3?=
 =?utf-8?B?QU4zc3YrWkY3REVYYkFzZUF2S1gwWVlVL0luZzdIaTlIM09SLzZ4emdUTHdr?=
 =?utf-8?B?elJkWk9YeEVnTWpLaTYxcDl5WjZGd3VjMU92Q1p6em1HdGh4WXNZREQ2TTFV?=
 =?utf-8?B?K0lZNjlLZTAvRFYzM3hvTDlzbWNYd2Q2SEhBQzdEeVVBUVFzc3h4OU1iYXhr?=
 =?utf-8?B?YnJBUDBRcHZPQldDRDMrRUZBS2s4OGtJbEdRSG9ac1ZqbzgyKzk4dVVoclln?=
 =?utf-8?B?ZThOQ09KWjJxTXJaaGEzNlFZWmR4TzNHczdrSDdmamRnYndOaGR0OUdLN0dM?=
 =?utf-8?B?NVVCYnk1cmFnL01FcnRCby9abnVla0ZWTHRxOTYxWU00c0tnaTNlTS9MM0ds?=
 =?utf-8?B?bzJ5bHRHQU9zVmlzcGREbUJ4T0JlWWxaenhkK09oQUVVVU1TcVZWUVJNRHVB?=
 =?utf-8?B?V3JoczdCbVFRRUdMMFBlVXBwRWRTSlRENjVJdmFUVGwxT0VZV2lyTUVoTUFQ?=
 =?utf-8?B?VTVSbXozd05LNS9KeXdyMFYybUM1WC9BOWh5Ris2N0dJR1I4MlUzZFBGaG5i?=
 =?utf-8?B?YVhGNzJCdjNUWnhrTVRNTHFYdjc0OSs0L3A4eXR5ZW1nNmh6V04ycWdrSHZ4?=
 =?utf-8?B?QUZWRm9JL2NubVZHZGhqcXUydmJ0U1ZLaXphdnFSaEVjdDl1ZnVwVzJNZmJk?=
 =?utf-8?B?SEhXNlZDaFd5d09jTEhaVHd4V1ZNZFBUMldQNDVhL1dOdzlxeWw5R2ZQY2ky?=
 =?utf-8?B?UmQ5VUhNajExaEdCaUQrK3d6Nk9MUmxWYitkbURNY053TGVPYkNTWGNsY2xC?=
 =?utf-8?B?cW5RTTAxUjlFTGRXMG9uMWpRanQ3c2h1SDhHanZMM2dDZGUzNlFDb21vQ3ow?=
 =?utf-8?B?VkNtYko5WWhmQ24rK2VUK3pXMzVzSSt2ZFBidjZoTDdTTEI2cXFoSlVjb25w?=
 =?utf-8?B?YSs0SmNLY0Z4NWRvSFl0Q0N4L3NVeGVuSjVTcTJmNDlnS3pKaVNHeHlsTXJH?=
 =?utf-8?B?MVNORFJST2ZvWkZyTVh2cHoxbCt5Rm1LeDVIVC9kS2lGOS8yOG9Hb3k4VitW?=
 =?utf-8?B?Z2hYWk1JeGU2QkNPRGtibGQ1bnlNMjFQNjRDdE5nK29qd2o0VUlqVk4yc3lR?=
 =?utf-8?B?V01zdy8vRWFMOUtQeThOWHJDenJ1dEFtb0xTN2pRTVo4SVNxVm8rRTUzUHRu?=
 =?utf-8?B?cTlXc2IrcHRiNzdkcFlvZndKUHc4SGNBc09KMGM1TFBVRnNaWFM5YWVUMFFM?=
 =?utf-8?B?bXRnMFdjOWl2TStzQzRsSWdkWk1iem9TZVJac3NNV1F3VE5pNWlxNWY5MVZv?=
 =?utf-8?Q?85f4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b781448-f1fe-4006-0e81-08dc6dadbd9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2024 09:20:15.7288 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kxJ9RDB/wKaKwNUkMptqJatmD4JRwHe1vwMayHSpbdyS4QAmdEXHT4h3/qJsl62iX7/BnR8GkmUHivmavxJAhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7173
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

W1B1YmxpY10NCg0KUmV2aWV3ZWQtYnk6IFRpbSBIdWFuZyA8VGltLkh1YW5nQGFtZC5jb20+DQoN
CkJlc3QgUmVnYXJkcywNClRpbSBIdWFuZw0KDQoNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KPiBGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnPiBPbiBCZWhhbGYgT2YgTWEgSnVuDQo+IFNlbnQ6IE1vbmRheSwgTWF5IDYsIDIwMjQgMTo1
OSBQTQ0KPiBUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IEtvZW5pZywgQ2hyaXN0
aWFuDQo+IDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4YW5kZXINCj4g
PEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQo+IENjOiBNYSwgSnVuIDxKdW4uTWEyQGFtZC5j
b20+DQo+IFN1YmplY3Q6IFtQQVRDSCB2Ml0gZHJtL2FtZGdwdTogRml4IG91dC1vZi1ib3VuZHMg
d3JpdGUgd2FybmluZw0KPg0KPiBDaGVjayB0aGUgcmluZyB0eXBlIHZhbHVlIHRvIGZpeCB0aGUg
b3V0LW9mLWJvdW5kcyB3cml0ZSB3YXJuaW5nDQo+DQo+IFNpZ25lZC1vZmYtYnk6IE1hIEp1biA8
SnVuLk1hMkBhbWQuY29tPg0KPiBTdWdnZXN0ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlz
dGlhbi5rb2VuaWdAYW1kLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfcmluZy5jIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCAxIGRlbGV0aW9uKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfcmluZy5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3JpbmcuYw0KPiBpbmRleCAxNWMyNDA2NTY0NzAuLmFkNDljZWNiMjBiOCAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3JpbmcuYw0KPiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmluZy5jDQo+IEBAIC0zNTIsNyArMzUyLDcg
QEAgaW50IGFtZGdwdV9yaW5nX2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHN0cnVj
dA0KPiBhbWRncHVfcmluZyAqcmluZywNCj4gICAgICAgcmluZy0+bWF4X2R3ID0gbWF4X2R3Ow0K
PiAgICAgICByaW5nLT5od19wcmlvID0gaHdfcHJpbzsNCj4NCj4gLSAgICAgaWYgKCFyaW5nLT5u
b19zY2hlZHVsZXIpIHsNCj4gKyAgICAgaWYgKCFyaW5nLT5ub19zY2hlZHVsZXIgJiYgcmluZy0+
ZnVuY3MtPnR5cGUgPCBBTURHUFVfSFdfSVBfTlVNKQ0KPiB7DQo+ICAgICAgICAgICAgICAgaHdf
aXAgPSByaW5nLT5mdW5jcy0+dHlwZTsNCj4gICAgICAgICAgICAgICBudW1fc2NoZWQgPSAmYWRl
di0+Z3B1X3NjaGVkW2h3X2lwXVtod19wcmlvXS5udW1fc2NoZWRzOw0KPiAgICAgICAgICAgICAg
IGFkZXYtPmdwdV9zY2hlZFtod19pcF1baHdfcHJpb10uc2NoZWRbKCpudW1fc2NoZWQpKytdID0N
Cj4gLS0NCj4gMi4zNC4xDQoNCg==
