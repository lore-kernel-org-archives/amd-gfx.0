Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5299A60A262C
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2026 15:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=sDavPQXW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDCCF10E225;
	Tue, 10 Nov 2026 15:14:49 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com
 (mail-japanwestazolkn19011028.outbound.protection.outlook.com [52.103.66.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9393B10E253
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2026 15:14:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IJ0GH4nczF2kOSfc3V4ScVHOxkC61V48l7/iyjkyqjw/PXkoFmcY4r9U64yO+XEZNQfS0FXWN3+ITjHUe3yUXpRmXc5xNtgKLw5kRxLdvAbpfzXf/H7BkUmC4OMbeq37Y7MaeqrrJYaag7Y6VxtVMHXasrkpGKiHteYWkfMo28yjEaXLqCk1UfDbI4WjAAsLpU3Y1h8B7osqzMLxXV87TTLPMrqPkt3971DAMSrsbKT9ZPKsv1LpFHrVQqG48zjgh0cBuRhR0dbJ5YtROJI1INs4NEpIL6Ai5SxoqEYl12ts6q9Z1Qi0p7ZvJ0QYaKkfiP3VUjC1DAmwt7s36C1S/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J2v5YZ9fz8QAHTcIdtbd4FXlThACVZbewmrW+YVqQBo=;
 b=kKue2XSVYvr0KgSSUbTI2KplWqb2mcjTlzGKidUZlsD5ULt9d38AG9o1OjGLXo/FehToe863OPDcd9ZUIFoCqs2uO3jHgyLZYeqt2dxFudaED99ya2XUdbNcKInsmQi0qWrfqj1u1HyJ0534spJSSIP8r0cffYSOo2FgpUOcRfP14WNtGqiLlu/YaAGVpEQg7tRursXfzG/1zFkaiaTiv+ZEVZSDB2pRKwYsBqfKdttq/BDWky8Tlmt2qUIylsdjnPSdjaE21OhRyxdnBf4qXSqNm+a7pWImub0yMTDuh5CuLNfVjTNefHwhbeaZEwjOMCxxlPe6sOZkdCEANX2apQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J2v5YZ9fz8QAHTcIdtbd4FXlThACVZbewmrW+YVqQBo=;
 b=sDavPQXWy1e3s5IkzOyD9R/RFPz0LU+6Jiw4z6ILqD7KAxGF6xz4oN+sXqyFKfBuWxnJRtUf8rLJcstCJcprXN+Cb1WU0H+AXs3z97iXzQaNZA8qQEdGS7OM9Tw68rTveLq2qKhqENQVm6MwtzgkDbJpSCsXHqaoXQPCcmRSQpNGkxRnvq2EXV0H7BjX0Ah1QTu1w/o7DWpqEzVb7u0VD7BTr0NieQppqfG7drMz0cUCi0q7SjtT56715QUx59Ef2/A7eRht/MDwLoAx7NMNCGPIsg/d7FwI3P/4ncSOke5YQf5eweVH3VPxvPUa5HA98OzJsDvVsOJjf9wINZXIxQ==
Received: from OS3PR01MB10251.jpnprd01.prod.outlook.com (2603:1096:604:1e1::9)
 by OS3PR01MB10090.jpnprd01.prod.outlook.com (2603:1096:604:1e6::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 15:14:37 +0000
Received: from OS3PR01MB10251.jpnprd01.prod.outlook.com
 ([fe80::7edc:2a40:7b8f:56f9]) by OS3PR01MB10251.jpnprd01.prod.outlook.com
 ([fe80::7edc:2a40:7b8f:56f9%4]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 15:14:37 +0000
From: "Jiaming Fan" <fan.jiaming@hotmail.com>
Subject: =?us-ascii?Q?[PATCH_v2_0/3]_drm/amdgpu:_fix_module_init_unwindi?=
 =?us-ascii?Q?ng_and_ATPX_handler_ownership?=
Message-ID: <OS3PR01MB1025124AAC2F9492FCB206AC6E7722@OS3PR01MB10251.jpnprd01.prod.outlook.com>
To: <amd-gfx@lists.freedesktop.org>
Cc: "Alex Deucher" <alexander.deucher@amd.com>, 
 "=?utf-8?Q?Christian_K=C3=B6nig?=" <christian.koenig@amd.com>, 
 "Mario Limonciello (AMD)" <superm1@kernel.org>, 
 "Kent Russell" <kent.russell@amd.com>
Date: Tue, 10 Nov 2026 15:14:30 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: TP0P295CA0016.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:5::20) To OS3PR01MB10251.jpnprd01.prod.outlook.com
 (2603:1096:604:1e1::9)
X-Microsoft-Original-Message-ID: <954c49b3-af5f-4579-b429-8d5ea3d0bf62@milk.local>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PR01MB10251:EE_|OS3PR01MB10090:EE_
X-MS-Office365-Filtering-Correlation-Id: d0d8aa6b-c565-4052-711d-08df3f3d55be
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|6090799003|23021999003|24121999003|25031999004|22091999003|51005399006|5072599009|15080799012|19110799012|8060799015|55001999006|24021099003|25010399006|440099028|3412199025|4302099013|1602099012|10035399007|40105399003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cG5EZ05POUM4ZE5RdVNYdTFYOC9xUE81ODl6aFRNVEhZZEtJM2FmOEhacmpk?=
 =?utf-8?B?TmZXSFUrcFBBdnY5WkVqaUIrT2k0RnRPRXE0eG9sdm53QmJZTnJ1VW1TbFdX?=
 =?utf-8?B?c09QUkp3bVJqNVlBZGZXUk41VXduMXM2bzYweEE2V1lCbXdvMHArUnFRcHBu?=
 =?utf-8?B?eXI2QXczdEFlYTNoY1M5QVFvMHkxN2V5eHQ5WWN4VTY1ZXBlazFOTkNkTVVV?=
 =?utf-8?B?MlJkSTJWcTBuOWtXT00xSnJreXVqTFc2N0RKWGZuWldadzg5SjZPbmlOOGhX?=
 =?utf-8?B?Y085bXpCZG9pT0xuV2tyOUpWVE5PSVdzcnFybFhTZ2RnSkY5dU0wdXJYdmRz?=
 =?utf-8?B?R3NxSjJlcXZxaHQzRVhRVU1SSjZmWjlRVkxqVGhhMFlEcUJiNG9mMzJyWU1u?=
 =?utf-8?B?Qmc4ZlVONWVCbFlDditDUTRMK0I0OU5GTG1zNnRkQm9tRStVWGYzVTdVdWdC?=
 =?utf-8?B?UnBWSGdTT21Yc0JuUmpIUzlaZjZ6Yk9tUWtqc3RnajhUS2dSeTdYOUtmQVYw?=
 =?utf-8?B?Y3kyeGJRS2QrNnArMFR2bzVLWVAzOEcwcWFwZXVKeTF0Tmg3dEhGaG9lU3JX?=
 =?utf-8?B?c1lyNGFKYi9VZSt5RzF5NTVObUFsVUlneEIzWm41c0lUYjR3Qk5GU014VmFN?=
 =?utf-8?B?RFBtd2ZJT0l5RGRMZEQxTUtCYXRnM0JPMVJmWVpEMzNwTFJXMFVqK1dyZXJX?=
 =?utf-8?B?Tmc3bFBVOTNaSHMzS0RiTzZWUDl2bW5LWHlPRVNGNTQvR1RUUlBuUlRCQi9W?=
 =?utf-8?B?ZE9UVDJBdEN2cTl1UkF0clVkY29OeGRXcCtqelgxK3hDQk9Qalo4MkZtUmc2?=
 =?utf-8?B?T3I1K1BGNDdIY2JORHNnbWFMTGNUNzh5c0hMZytLR0J1a0R3MnJZYUMvSmpO?=
 =?utf-8?B?Z0RDdDZwaE11SGEycHFoc0tNK0hwK1VhNzZCbWNmdnRCZ2ZEcXl3YWRKRUlx?=
 =?utf-8?B?dDNSVi8xYy9KbmhVRWJPZ2NJSFErNTBPSm9VUnlheVQrcDZycEhuKytiTzZW?=
 =?utf-8?B?b2RyS3NiUmREYVpQYWJRYkJtN1ArN29EajV6ZXN3dnVLOGVQak9FdHBoaGJo?=
 =?utf-8?B?VVNlVWJUUExLWE4xUm9jVmdUZnY3ejdtdTFzL0FRU3EzZmw5NGJzR0VHbWh0?=
 =?utf-8?B?VHBHbk4yUXpUYXdHRzI3QTIvaXpqVWh1R3gvT3c5QWY3d05GMEMvNDJqZzFC?=
 =?utf-8?B?REF5dW95d21uMUJXZWxmQnFCS1dRc1FlOTh4Qys4aVdhQWtaV3VrQlBwVnFL?=
 =?utf-8?B?WmtoQ3BLNmpDZVdCRytPeEZxYUlYeWg5ek1IVHR3dnlQQjRaTzJrcDBOMXpQ?=
 =?utf-8?B?WTFTc2dBcWF5UHR5Wk9ES2RGR2ZOZW95THEzRVFwM3c3MTZEYUp0Y1V5K3Jj?=
 =?utf-8?B?TDcxc2s0ZG13WEsyWk81VkJ5TWxXMTA5TmptS1grc0dQdk8ycExnUGsvM2VF?=
 =?utf-8?B?MnNGdnVrWTZQMmdxODBDTmNxYVBqUnljdFJxOUlFekRYRERZbnJRV2FvOUpr?=
 =?utf-8?B?ZkRHdEpRa1U0K2pUZlhldGlNQk5VSTNMZXpuQ0sySWFWWlNDQUx1UnJaamt3?=
 =?utf-8?B?SVJPdz09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmRycktkUXhneGZxUmFybS9ZRkJUOWgzOE1hSWNGUEdxNkZ3Wm1vQ2JCQ3Zh?=
 =?utf-8?B?TWUraG5rckZmQTRYb0J1bEhIOEdqZDRpektGRUtNazE2dWpuMXNoOUtxWUtj?=
 =?utf-8?B?UTU1dDczOE5xenZVTHZuamJMa01aU1JLYWZRRFdBMFZwVkZiN0ZaYzNYWm8v?=
 =?utf-8?B?N21mMDcraDExc1FOY0J6SmhYNWpjYUMxOVpFTk0wWE5UdGJKaWx2dFJqd1o4?=
 =?utf-8?B?ZzdabU9oRmRINzVKL2RwbjZva1VZbk5ZVzFWOG1zOHVaWnQ1YVgzS3FIT3M0?=
 =?utf-8?B?T2w2ZVk3eE9HKzFFTDFlSmZwSHdaS3lEeVNLTlErN1hiSTUrQm5yWFRzZElj?=
 =?utf-8?B?cmI2d2RsMW4zTzd6TXp2anZvdXg5SmNjVGk5Rmd6OXovbGtmMnV4eG5lcmlX?=
 =?utf-8?B?SWEyRU10aEErOFViUmlQTlZpeDJZaDgxejYycURVQ0JGZmRYTVdrUHpJRlBO?=
 =?utf-8?B?c0VocGdSRlhiTWJmcDk5VTBBdTU5RmVlQStkWllHRGNJWjV0NGFyZ2xrSzho?=
 =?utf-8?B?bWNGL1U5SzYvSTVZdWt0UjhZd1M2SFNIVFZVRmwzSytsbjZUVTZnS1BiOGYz?=
 =?utf-8?B?L3ZPME5Zc0hmNGxjZ1lBNkVlY0lzV1ZNUlZFcHNUS3dlNXZRb1pGbFZaTXl6?=
 =?utf-8?B?TXhOa1VncXljMUp6dXU5UnNYdjFsSHVzQ1NKczlNcU5Ed25QS0lUVm85TTFv?=
 =?utf-8?B?QkNGZmszaEFpRE1tTVpCTlRrVFREUGxkR3ZrMjJjUnV1UVFsdndlZHpHeFhp?=
 =?utf-8?B?OGFPNU5wZ3pBWlExYzNORkhWOTRzVzY0WDFIbEZZUXcyODJ1R0lXSFRpM1Zy?=
 =?utf-8?B?N0xUZVhEcW9GMytKNFFQcno1ZFJudy9RMkpLR05GN0NDNnBGdGxnSVlPRXJz?=
 =?utf-8?B?WjREMytCb242d00vL3lUWVByb2gwQUlieUhmWllEVGptMldMZFkzamZwcGtv?=
 =?utf-8?B?MDFMK1dtbkVma3JuUFZURUEwd21iSUFOR25Bdzc2NjNvMG9sOWUxMTB6ejNi?=
 =?utf-8?B?Z2tQSU1Oa21nYU5HK2tMNEZjU2g2dU10aG5PeG1qcGlsT3pKSk9sWnd2eEF0?=
 =?utf-8?B?ZE9lSWEwbk9iNnI4SlZtY1hNWjM1N3IzOFJWWjBnZEswcEUyOURJS3dnOWtt?=
 =?utf-8?B?WWt4OCtTSkJsOWVwM0FKbW4vN2gyeUFwNVBQbDQwYTNUYXlSemphb0VJd0Ew?=
 =?utf-8?B?Z3lBMStxMHBUbHFNTElkYVBEcGJ0V2YyRDRQaitFaFlJNWJwdkxlakNwakQz?=
 =?utf-8?B?enRKWWJuRFVQMXBvVFhyRGY2OGtoVy91aitqOTNPRFRWTHArWUs0dlN5M0dr?=
 =?utf-8?B?bVVqcmNLYklkK1Vibnc3WE4wZThadmVaT1AwSGVWemgzQzk2SGhVc1FuSVVY?=
 =?utf-8?B?eW9DN2YxTmp6V3E4eUF4U3dXT1lVOTF2enVDSzNSRkVkZFpEazJWYks2bUkv?=
 =?utf-8?B?SENQUDlnaGNIODQrNTdIMFo5cmp2eWxnY2RlcndNSUY0Mkp0RnY2WDJjOG9Q?=
 =?utf-8?B?T09kVEdyckY0dTN5Z3g3UU9DSGlOQkdJUmwrdDNBVFBqKzczc1FjNWkrNFNm?=
 =?utf-8?B?ZTVGcitKeTV0bFc2aDdIWFlYNXpQWEZEWlkrM09GeHlNcVdrNy9LRnU0MUE3?=
 =?utf-8?B?YlZOallDalJMV1pOdE1DaXdrcDB0QVZMZ3ZsVUdjeG1BRlQ1QzQrMlNkdnMy?=
 =?utf-8?B?VkJyL0RxdHB0ZDZGK0hsbC8xczdrVEx5bU9kTzlWMXMwcTdIVWVqdDVFR3NM?=
 =?utf-8?B?ZGd1dE1WaFF1SzlIWHQveFJKd3dLWUtvUkV5R1VTR2crOFBOVVptWitCQytX?=
 =?utf-8?B?QmNSdGgyUTJBNlZTYldZamN0d2NiREJ5ZStuZWVOZ296MldRUy9WbmlXUFlu?=
 =?utf-8?Q?lMpOdoo4Yd5dn?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-b83fc.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: d0d8aa6b-c565-4052-711d-08df3f3d55be
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB10251.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 15:14:37.6053 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB10090
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

amdgpu_init() does not undo its earlier steps when KFD init or PCI
driver registration fails. v1 [1] added that unwinding. While checking
it against amdgpu_exit(), two more things came up, so this is now a
series:

1. amdgpu_unregister_atpx_handler() clears the vga_switcheroo handler
   even when amdgpu did not register it, e.g. when apple-gmux holds the
   slot. amdgpu_exit() has always done this; v1 would also have done it
   on a failed module init. Patch 1 fixes it and goes first so that
   patch 3 does not add a new path to it.

2. amdgpu_exit() does not undo amdgpu_init() in reverse order. For the
   ATPX handler and the ACPI info that is only historical, so patch 2
   swaps them. For KFD and the PCI driver it is required, so patch 2
   keeps that order and adds a comment explaining why.

Patch 3 is v1 rebased on top: the error path of amdgpu_init() now
undoes the steps in reverse order, the same order amdgpu_exit() uses
after patch 2.

Changes since v1:
- New patches 1 and 2.
- Patch 3: commit message updated to refer to the order in
  amdgpu_exit(); no code change.
- Patches 1 and 3 carry Cc: stable. Patch 3 depends on patch 1 and
  should not be backported without it.

Only build-tested, on the ROCm amdgpu tree with W=3D1, LLVM=3D1 and
CONFIG_VGA_SWITCHEROO=3Dy; I have no hardware with ATPX or apple-gmux to
run it on.

[1] https://lists.freedesktop.org/archives/amd-gfx/2026-November/157013.htm=
l

Jiaming Fan (3):
  drm/amdgpu: only unregister the ATPX handler if we registered it
  drm/amdgpu: undo module init in reverse order in module exit
  drm/amdgpu: unwind module init on failure

 .../gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c  | 13 +++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       | 24 +++++++++++++++----
 2 files changed, 32 insertions(+), 5 deletions(-)

--=20
2.56.0


