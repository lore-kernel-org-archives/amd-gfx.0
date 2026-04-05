Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35AC5EDB7CA
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Apr 2026 07:44:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA1BE10E357;
	Tue,  7 Apr 2026 07:44:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=OUTLOOK.FR header.i=@OUTLOOK.FR header.b="brIsW9/2";
	dkim-atps=neutral
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazolkn19012014.outbound.protection.outlook.com
 [52.103.32.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBC8310E17E
 for <amd-gfx@lists.freedesktop.org>; Sun,  5 Apr 2026 16:45:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GoYeRbvhitWicS0oKb7hhDN08wHUict8Yp9cnvnWtsRswDFyxMGoYlo/mGI8Ytk3LHfwO6KZrrllfWJ6kWOUvl8lpuKUbqxH/9zoMyHI5rbtSXnVoh4YAmJneK3TCGhwez1utZUBAgZEsgIBOQX2DL5z+tQP/0E5wZl7Wy9EDHPIta9FckCKt4h5HIcU8enauL9XYhCgLn/lOLIUvtrp+fk8qcNaErns4m50pSwgCxYqWdIJjTQ7dHnAYiVgfSfXxVaP4z9XLiO8xOoTDmIWL2DPbw5a+14JF1J4iykzGT2Iv/buOqfmMiDdokEuvCXtR7Kg3+E1ih3VqEPFiDJj6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sR8jzuprMggjJbwJlIjvILG00cBJ6solfM7guqxcmRQ=;
 b=ABy4L92iCLaZnA1MYGy0ZiyqI/RPkOGg/FIpMBzQlnmBvyLkNkV3IAr5/5ATrrBUkn5CaXFLOYreORLZLfQozyMHF/Wuw+8RLT00F/MMmZKbWgSXyAp1/dRG05FdodXJPYtVgjI8Kcv4z01aTVozzXuyGx8z4yk36tW7+nK37ZLPt2mFoKaAouR5kFZKgB6zVp9wD4fpro5qBBRMbKRxqBBD0lWEFYakGJ4OvJViV0C8bEwGabsjrODWekJrHi4YZWcmi6g2PYMU1zY1wygNTwJOJRW4tmJ3wYCI/mVwuYvdVNzn6zfYISnA4KO5z9WUNAJfUVhwW31XwyH81XnZ5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.FR;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sR8jzuprMggjJbwJlIjvILG00cBJ6solfM7guqxcmRQ=;
 b=brIsW9/2bdgQaOEnZOHjl23tS6d9znRCIQKRJke/BWllMIeBhVpVbqFy01jzaw2D2n9pKZj3ajVyVLkAuF58aotTIizb3N15pSwWBg2ldEqvi9Jvr3fyOuGBvDGy2H7oGpEbeSYWpFv3ten7OTW+Ilu3Z+yATsJ8Mft5oG2DfPEDs8Mf/KkS4BpnjIw4zvkfHa3gNqTjf+uxc/7YrzZGaOATVq6AXHwqbgPrFrf9tIeyfwPqGnVyhedKjVKXcaADBmq3zB+G0kD/jGQLOUHN9YeB2DEOh6kT90s/Pr4+JMQCG0wahvJtgVkpLIc4l0GYoao2ERbU9Yhx3BdKI+Pl3Q==
Received: from VI0P251MB1186.EURP251.PROD.OUTLOOK.COM (2603:10a6:800:2c7::9)
 by PRAP251MB0590.EURP251.PROD.OUTLOOK.COM (2603:10a6:102:29d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Sun, 5 Apr
 2026 16:45:24 +0000
Received: from VI0P251MB1186.EURP251.PROD.OUTLOOK.COM
 ([fe80::4df7:d492:7941:a68c]) by VI0P251MB1186.EURP251.PROD.OUTLOOK.COM
 ([fe80::4df7:d492:7941:a68c%5]) with mapi id 15.20.9769.016; Sun, 5 Apr 2026
 16:45:24 +0000
From: outlook user <RACP@outlook.fr>
To: Alex Deucher <alexdeucher@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: Inquiry: Raven Ridge `RLC_RESTORE_LIST_CNTL` failure (0xFFFF300F)
 on Kernel 6.17 - Missing GFX9 fix?
Thread-Topic: Inquiry: Raven Ridge `RLC_RESTORE_LIST_CNTL` failure
 (0xFFFF300F) on Kernel 6.17 - Missing GFX9 fix?
Thread-Index: AQHcp0FINCiukw/80Ua+DqPOnGFf1rWWmJkAgDpOT9w=
Date: Sun, 5 Apr 2026 16:45:24 +0000
Message-ID: <VI0P251MB1186893688FCE4AFDF9953E3975CA@VI0P251MB1186.EURP251.PROD.OUTLOOK.COM>
References: <VI0P251MB11869B2637BE556CFA76E6C89772A@VI0P251MB1186.EURP251.PROD.OUTLOOK.COM>
 <CADnq5_MTCBEcdu_c_4g=-fq22negivw_98r_NOzmnAHVXkdL=Q@mail.gmail.com>
In-Reply-To: <CADnq5_MTCBEcdu_c_4g=-fq22negivw_98r_NOzmnAHVXkdL=Q@mail.gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI0P251MB1186:EE_|PRAP251MB0590:EE_
x-ms-office365-filtering-correlation-id: 631e6585-6639-4c2d-9100-08de9332bc02
x-ms-exchange-slblob-mailprops: laRBL560oLS7IWERjHonlu/qsKr3Bu1ZlAEZyX8rzbFkpwrepcTxcQSil7EiDF05LfEw5JyruXAXQ7SskIBqcAqnVlW7fZm+w1t3Dp1DJUgrcWSQH5NnlW4HAU3vLFpnFRNPxvp2n4MPizDvs7z8vLrIyMXQakGgfjYQt/q9MCSXPIJly1MmT6iJP4BprsR5vuU3d1kPWtYuSaCsJyWWvRHozR4QBgq5L/L/NJRqnDtfAUXnCYDn6kJ8YYBhxqGCesJsh5IR+IHQT/+WEtrull7GZHl2XNZIKLIJAz6h6u6t1tL7fQUO7+pCX36AeViQFAGRTpAEip4+E9Hac1NxWu4ziu+rgwbxSKTj01ke26RdRCnuiduLbIs2uwEddEuuGubsG9jZ1tpOlmwYSeHU15vaMR4wOv7hxKTLJE1rtfQ1EQOuAi8L6wlriAPMkuBohgiTBrEqQBZYPeJtexracyOFb7lnDrww+RVMqnvEfZyZlotVx48hfNJfv2bVAfb+s5lj3R5wurLX/+xqIi8JM0l0o9MCL8ArEm6yeWMIbmU3lynG1LrwA2IFN7kfWR5sgkTwP5aZVcagBE2MOsd+SQBBC79THkGVHRGWcDY0FieWucQDENb3eTi9KI2y/29anT0XFWXBNE9Bf8Pc9gcdgxxThD0V8Lzdycns3jCK+svd3IzQ2knOjA32qp3jJlRgV12/zlWDWorrlkngekPZzAwzDtksxsVF1F8l4e31/WVuyqsKCxXCmm99ErMo7av+ZHjgfi/Roii21Wwyq+rRVQvF9qZstUFb
x-microsoft-antispam: BCL:0;
 ARA:14566002|24121999003|13031999003|22091999003|12121999013|51005399006|31061999003|25031999004|8062599012|19110799012|41001999006|21061999006|15030799006|8060799015|461199028|15080799012|40105399003|3412199025|440099028|102099032|26121999003;
x-microsoft-antispam-message-info: =?utf-8?B?MlYyZXRNRy94TXVXRlNodVZBdlJkakZhSFdrd3RJeFlxNmREZnd0TXN4a2hz?=
 =?utf-8?B?cFgrT3k5LzNNbGVtN00zNHlvVFRqV09CK2xMYS9nSkVXZ3RoZ3ovdmpnZk9s?=
 =?utf-8?B?TDRwb0Y0RWNJQ2F1ZlRrYWM0czdtT0R2K1Jwd3I4eFFFU0cvRllScnhtQ0tn?=
 =?utf-8?B?OGN0VEM2WEZ6ejBZbHhhR2xnUDZDZ1ovQzNxemtBOGNQUW1RcHJSOUxoWlZR?=
 =?utf-8?B?TzdRQ25TNTV0TnVFalp0bWFLVUNUKzBBL1pjMHBXRk9INW1IcHF0SzdKQS9F?=
 =?utf-8?B?VktaNkdHMEtvcEtsK29rTWNacndzaWM5OWZGeXZtNWRETUxyeGpQODYxVERO?=
 =?utf-8?B?R29QUERWN1VKNEozWk5WbEVCekRDZ3B6Y1V5N0VKSSs2SnYxcEtoZ3FsL2s5?=
 =?utf-8?B?STBvbjdPMUFIUEtSUjNZdC92dHF5Z2hVSU5JWlE3OFlDeEJNbjV1VXdzNklP?=
 =?utf-8?B?RFU0STEyMFlOeS9iTktDWVJQV29ZMWVwekpmWmRYTXo0SmhmV3B0dUIrUzJQ?=
 =?utf-8?B?VnJ1NkFYRlZTczdXYWVDRGxWZmgzWVFlaGRiQ0NmeW40My9tMml3aVBUSmht?=
 =?utf-8?B?NXlwYUd3eVJiZUtpWGJ6L2hWTlpUVFNrMmR5elhNMWpWRXRUaG4zdVpFaEhk?=
 =?utf-8?B?MHR6UWpiTmYzeUVlQzlFS2FWUFpScFRKNVRENmZ6Sy93UmVVK2E0bG1RSTdN?=
 =?utf-8?B?V0JYUlZzZno5eTAxblRwTUVicDR2ZXJGZitjSjNzQVdaMkVoeVo3NUJDdTFv?=
 =?utf-8?B?OVJoSS9scHEzc2YvMnFFY2pGSnpVdi9mZVBTYjc0RDV6czZDOW1kU3A5NWls?=
 =?utf-8?B?SUZDM2R2WVhZZG1GVHVDblZSNENwQkxGM2V5NWh0RTZ3WHN3dEEzVHV5Z0VT?=
 =?utf-8?B?am9nd0UzVGFsQ21sNjJ3Sy9IK1NMWWxycXJRN0M3SFhKaHRjRnJuaHlhY2Nz?=
 =?utf-8?B?dWl1WDBXRXFPMUp1YWVpSEdnQnE3N0dGbFlzNXFvOUE2cHBGMVBtUWtIRDVR?=
 =?utf-8?B?UXU2bzYvNEFzZmYyNlRzb29reEtkci90Y1dhQWJrWjRseHBXbnVaMlIvMWc1?=
 =?utf-8?B?RGFXM2UvRDNpbTFwSW1kZTI2UGJRL1pVNnhiZ1hJUUVNQzd0bnloQ2IrM2xH?=
 =?utf-8?B?VkdvKys5clo4eFNyZDY2R1hnM2RiRThOUXgrL29RSTI2d2dzRWZFMVpqWFR2?=
 =?utf-8?B?MVRWVmFzMVBadEFMK3FEd2dFRllQQURCbjFrR0ptaFM4NlhxM0ZDTVJMNXBh?=
 =?utf-8?B?YjEzR1VxSlB6eDhiU3NmYzY5VzVaU2lPeWwzNnU1QklmTVdqOU9FUDJhRnQw?=
 =?utf-8?B?T2FxVkdvYVFOWGdObW9aVENXU2JOS1ZseExlcmloR1huUWVGN0E2SU85dHFS?=
 =?utf-8?B?L3F4NGpMbHBvcHRITVZSOEdhRnJic2NPd2ZvZUhpZ2xQdXE3NFpsb3lZRU5n?=
 =?utf-8?B?L1V6bjRXcFdGUityZmdSR2VRbTZXd1hvZUp6WGZwL003ZkpMUkZJMjR3dC9X?=
 =?utf-8?B?S09KMEIxR3ZMZ29iT2E0YzZvL0lRbGRlcG13M2o0NkhxdVFoeUhWUGdvbGxa?=
 =?utf-8?Q?2SMkfy43I/RG38Mir4JUTOIYwxNyGNquE13UPBu+gMB469?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MXNQVHRTVi9ydVdsOHRaZVpscGx3ZWRPdHlvWXZKeWhlMTlBMmY3Yy9vdWJm?=
 =?utf-8?B?MmRyZ21tWGgxbmk0aW5id29TNTVtcWEwc3VMa3lpZjBjSWt2bktVOU5seUli?=
 =?utf-8?B?NVQrL0xPZTBsTXFlN1l3Kzl3QWJFWTRvd1gyMmhLSlRYdkFVWElEbFhTYnMr?=
 =?utf-8?B?RExtZ2lDd0VZejlZMnZKZ1VBWExwY0pMUCsyUmhZeDRFckorVUNYSTByRE9P?=
 =?utf-8?B?ZUVWb1p4Y3RYNE1pbXp2SmdDUUpPUklMMDR2N3F5YW5NdjRpcHBQTEVPNnUw?=
 =?utf-8?B?eTYwbzh2ejVvMC9qSjdjdHJSRHJocHh0MDcwdVVIcXp1OVgxd2hYd0pOSXhh?=
 =?utf-8?B?VkQxN3M0S0psTFAzR3QyVlhSTU1xRjhLWG53cnFMNWxGNENJeDJGRlhrSVNm?=
 =?utf-8?B?NW9SRGRoVkVLdW1zc3IrNGhZKzVUQkJNT3h1ekg0dHcwakNnSGJ4bEhsQTdk?=
 =?utf-8?B?eWsyRzBBb3p6RUEvYUhHdVBsV2hJSS9GMUY4YThRM3RQLy8rWXdhKys2VGRu?=
 =?utf-8?B?Z1NUdGdONXZUS3VGdEVXdTNxN2JTdVhKN1lyaEIrVWlXVnI4UjdadWd3U1ZF?=
 =?utf-8?B?bnVIb3pjSWV5bldTdzdFTjl2cWd0ajg1d1kyS3ladmR5UVFlVnlHR0VNb09I?=
 =?utf-8?B?ajcxZkF5ZE03MmQraXZacUY0c1I2VzBGTUJBcG5QWk1RREdIZGx3UWlJem1o?=
 =?utf-8?B?Ly9PRlNYck5PZ3UwZzZrK2FudFV5K1RLekU0dTFMaE11QjNxUmRSU2tTRU9v?=
 =?utf-8?B?N2VaaEFBcE1OMnRMcWhOMTFMWnhlY1J6SmF2NFVJK1VybGlobjk3MWRXMFhK?=
 =?utf-8?B?UGJ2WWdkSDRSY2RkU2UxYi9EUkFBS3FjTmcvTTROR216SkI0ZXpnWlJqOFhx?=
 =?utf-8?B?NjJRT2pmYU9LL3ZqZ21pcDd0a2JJTXlMYlEyQnRDNWR1aXo0bVo4YTM1QU9L?=
 =?utf-8?B?MDFpVFpoZW9CN2Q3K3ZYTDlmWWs5K3VOdVp5QjNPMUJrTGt2VUtCNzZCc3RW?=
 =?utf-8?B?U1JnWnZrY2EyZGcwaUI0ZEE0L0wvNFdVV3FDbDF5WGxLV1NYcjVkU255QVhT?=
 =?utf-8?B?TTlHZFVReEEwSDE4SkUxRS9RT2t3c0NjMWlqQU1rbkpIRE1xRThoMUZyd2lG?=
 =?utf-8?B?dlVoNTNNa04zWjF3b3NXNXBVTG56ZUlZSUxBVW5uaGRWeWhIR0xCekdYYklK?=
 =?utf-8?B?RTRqZmZTbVhJT3AyeVA4QkI0cU9wd1JYUndJVUd4MDlQcUpXbHh3THhpVFp0?=
 =?utf-8?B?RW5lSmwrNWdoTWNtYVRPcTI1TjlQVG0yT0IzSkQ1UjNJMWJLQVBLL0tWZTFa?=
 =?utf-8?B?UHVYamlGbFJsdENCL25UZVNDZVB6OG9oa3FWWkFTaVhJN2ZxbDgwTXhIQS9H?=
 =?utf-8?B?SVJjVGJQQVRDWlJhMzNKMldXSDZNUWFndXhqNFlXUFpuKzFPMFpZVTRST3Y3?=
 =?utf-8?B?V2FEbWZPQ1J4M2RpSUVYb3N0QXRJdy81a3NkTTRkNm9scjVENUxlZ2hHWDM3?=
 =?utf-8?B?MjkrS1FteXFpWTNGRWNPOS9yMFBwaEhVQWFMY2JJLzVNbEEyeDZrWjJtcFg4?=
 =?utf-8?B?clBsWkh5eUIyQ2I2SndwdlZocHhPRXFCeE05YnlIK3N6bmVSSjVYQTdYZkpm?=
 =?utf-8?B?QS93eHpudkZjVVYvT2Q0MjdndFFqdHQ2RHRLb3BtejlhNklzUFRiSStkc25B?=
 =?utf-8?B?ZlBUVTlXMXpUN2pFTDBqYkJobXBNMFBjcGtiekRDOW1zZGUvdmhSdUdoMVJT?=
 =?utf-8?B?QkVSU0Y4emxDNmZVQkJoQ21JT0NLSTZ0anNpVDNlWCt4OHQrdUVrV1JiSFgz?=
 =?utf-8?B?RitabWhEbkM2L0NVZFRna1krQW5KellmemI5Ny85bGtuTG1STktWcVU4UWJ5?=
 =?utf-8?Q?14TD3cGCnYGzv?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-fe3f5.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI0P251MB1186.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 631e6585-6639-4c2d-9100-08de9332bc02
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2026 16:45:24.4979 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAP251MB0590
X-Mailman-Approved-At: Tue, 07 Apr 2026 07:44:50 +0000
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

SGkgQWxleCwKCkZvbGxvd2luZyB1cCBvbiB5b3VyIHN1Z2dlc3Rpb24gdG8gY2hlY2sgZm9yIGNv
cnJ1cHRpb247IEkndmUgdmVyaWZpZWQKdGhlIGZpcm13YXJlIGZpbGUgaXMgYnl0ZS1mb3ItYnl0
ZSBpZGVudGljYWwgdG8gdXBzdHJlYW0uCgpMb2NhbCBmaWxlOgogIC9saWIvZmlybXdhcmUvYW1k
Z3B1L3JhdmVuMl9ybGMuYmluCiAgU0hBMjU2OiAzNzBiNDUzZGFmODBhZTIyYjQwNDUxYjk4NDU0
YTRhMmM5ZDFkZDMxNjhhNWFiNjY0NTA5YTI1NDkzMDcwZTczCiAgU2l6ZTogMzgzMjQgYnl0ZXMK
ICBQYWNrYWdlOiBsaW51eC1maXJtd2FyZS1hbWRncHUgMjAyNTExMjUtMiAoTWFuamFybykKClVw
c3RyZWFtIChnaXQua2VybmVsLm9yZywgY29tbWl0IGJhNDkxZjYwNDY5YywgImFtZGdwdTogVXBk
YXRlIHJhdmVuMgpmaXJtd2FyZSBmcm9tIDIxLjUwIiwgRmViIDIwMjIpOgogIFNIQTI1NjogMzcw
YjQ1M2RhZjgwYWUyMmI0MDQ1MWI5ODQ1NGE0YTJjOWQxZGQzMTY4YTVhYjY2NDUwOWEyNTQ5MzA3
MGU3MwogIFNpemU6IDM4MzI0IGJ5dGVzCgpUaGUgZmlsZXMgYXJlIGlkZW50aWNhbC4gVGhlIGZp
cm13YXJlIGJsb2Igb24gZGlzayBpcyBub3QgY29ycnVwdGVkLgoKVGhlIFBTUCBvbiB0aGlzIFJh
dmVuMiBzaWxpY29uIGlzIHJlamVjdGluZyBhIHBlcmZlY3RseSB2YWxpZCBmaXJtd2FyZQpiaW5h
cnkgd2l0aCBlcnJvciAweEZGRkYzMDBGIG9uIExPQURfSVBfRlcoMHg2KSBmb3IgYWxsIHRocmVl
ClJMQ19SRVNUT1JFX0xJU1RfKiB1Y29kZXMgKENOVEwsIEdQTV9NRU0sIFNSTV9NRU0pLgoKVGhl
cmUgaGFzIGJlZW4gbm8gcmF2ZW4yIGZpcm13YXJlIHVwZGF0ZSBpbiBsaW51eC1maXJtd2FyZSBz
aW5jZSAyMS41MAooRmViIDIwMjIpIOKAlCBvdmVyIDQgeWVhcnMuIFRoZXJlIGlzIG5vIG5ld2Vy
IGZpcm13YXJlIHRvIHRyeS4KClRoaXMgYXBwZWFycyB0byBiZSBhIHNpbGljb24tbGV2ZWwgUFNQ
IHNpZ25hdHVyZSB2YWxpZGF0aW9uIHJlamVjdGlvbgp0aGF0IEFNRCBoYXMgbm90IGFja25vd2xl
ZGdlZC4gVGhlIEdQVSBzdGlsbCBpbml0aWFsaXplcyBhbmQgZnVuY3Rpb25zCihEaXNwbGF5IENv
cmUgdjMuMi4zNDAgb24gRENOIDEuMC4xIHdvcmtzKSwgYnV0IHRoZSBtaXNzaW5nIFJMQwpyZXN0
b3JlLWxpc3QgdWNvZGVzIG1heSBjYXVzZSBpbnN0YWJpbGl0eSBkdXJpbmcgc3VzcGVuZC9yZXN1
bWUgcG93ZXIKc3RhdGUgcmVzdG9yYXRpb24uCgpJcyB0aGVyZSBhIGtub3duIHdvcmthcm91bmQs
IG9yIGlzIHRoaXMgYSBmaXJtd2FyZSBiaW5hcnkgdGhhdCBuZWVkcwp0byBiZSByZWdlbmVyYXRl
ZCBmb3IgY2VydGFpbiBSYXZlbjIgc2lsaWNvbiByZXZpc2lvbnM/CgpIYXJkd2FyZTogQU1EIFJh
ZGVvbiBHcmFwaGljcyAoUmF2ZW4gMiwgRFJNIDMuNjIuMCwgNi4xNy4zLTEtTUFOSkFSTykKRmly
bXdhcmUgdmVyc2lvbjogMjEuNTAgKHJhdmVuMl9ybGMuYmluLCBsYXN0IHVwZGF0ZWQgRmViIDIw
MjIpCgpUaGFua3MKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KRGUg
OsKgQWxleCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+CkVudm95w6kgOsKgdmVuZHJl
ZGkgMjcgZsOpdnJpZXIgMjAyNiAxNToxNQrDgCA6wqBvdXRsb29rIHVzZXIgPFJBQ1BAb3V0bG9v
ay5mcj4KQ2PCoDrCoGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnIDxhbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZz4KT2JqZXQgOsKgUmU6IElucXVpcnk6IFJhdmVuIFJpZGdlIGBSTENf
UkVTVE9SRV9MSVNUX0NOVExgIGZhaWx1cmUgKDB4RkZGRjMwMEYpIG9uIEtlcm5lbCA2LjE3IC0g
TWlzc2luZyBHRlg5IGZpeD8KwqAKT24gRnJpLCBGZWIgMjcsIDIwMjYgYXQgNDoyOeKAr0FNIG91
dGxvb2sgdXNlciA8UkFDUEBvdXRsb29rLmZyPiB3cm90ZToKPgo+ID4gSGkgdGVhbSwKPiA+Cj4g
PiBJIGFtIHJ1bm5pbmcgYSBSYXZlbiBSaWRnZSBBUFUgKFJ5emVuIDUgMzUwMFUsIGRldmljZSAw
eDE1RDgpIG9uIGtlcm5lbCA2LjE3Lgo+ID4KPiA+ICoqVGhlIElzc3VlOioqCj4gPiBJIHNlZSBw
ZXJzaXN0ZW50IGZpcm13YXJlIGxvYWQgZmFpbHVyZXMgYXQgYm9vdDoKPiA+IGBhbWRncHU6IGZh
aWxlZCB0byBsb2FkIHVjb2RlIFJMQ19SRVNUT1JFX0xJU1RfQ05UTGAKPiA+IGBwc3AgZ2Z4IGNv
bW1hbmQgTE9BRF9JUF9GVygweDYpIGZhaWxlZCBhbmQgcmVzcG9uc2Ugc3RhdHVzIGlzICgweEZG
RkYzMDBGKWAKPiA+Cj4gPiAqKkNvbnRleHQ6KioKPiA+IEkgbm90aWNlZCB0aGUgcmVjZW50IHBh
dGNoICpbUEFUQ0hdIGRybS9hbWRncHU6IGZpeGluZyBybGMgZmlybXdhcmUgbG9hZGluZyBmYWls
dXJlIGlzc3VlKiAoQXVnIDIwMjQpIHdoaWNoIGZpeGVkIGhlYWRlciBzaXplIG1pc21hdGNoIGlz
c3VlcyBmb3IgR0ZYMTAgYnkgc3dpdGNoaW5nIHRvIGByZXF1ZXN0X2Zpcm13YXJlYC4KPiA+Cj4g
PiAqKk15IFF1ZXN0aW9uOioqCj4gPiBTaG91bGQgdGhpcyBmaXggYWxzbyBhcHBseSB0byBHRlg5
IChnZnhfdjlfMC5jKT8KPiA+Cj4gPiBNeSBzeXN0ZW0gaXMgY3VycmVudGx5IHVzaW5nIGBhbWRn
cHVfdWNvZGVfcmVxdWVzdGAgZm9yIHRoZSAia2lja2VyIiBwYXRoLCBhbmQgdGhlIGhhcmR3YXJl
IHJlamVjdHMgdGhlIGZpcm13YXJlIChsaWtlbHkgZHVlIHRvIHRoZSBzaWduYXR1cmUvaGVhZGVy
IG1pc21hdGNoIG1lbnRpb25lZCBpbiB0aGUgR0ZYMTAgcGF0Y2gpLiBUaGlzIGxlYXZlcyB0aGUg
R1BVIHdpdGhvdXQgUkxDIGxvYWRlZCwgbGVhZGluZyB0byBpbnRlcm1pdHRlbnQgc3lzdGVtIGZy
ZWV6ZXMuCj4gPgo+ID4gSXMgdGhpcyBhIGtub3duIGdhcCBmb3IgUmF2ZW4gUmlkZ2UsIG9yIGlz
IHRoZXJlIGEgc3BlY2lmaWMgZmlybXdhcmUgdmVyc2lvbiBJIHNob3VsZCBiZSB1c2luZz8KPiA+
CgpUaGF0IGdmeDEwIHBhdGNoIGlzIHVucmVsYXRlZCBhbmQgbm90IGFwcGxpY2FibGUuwqAgSXQg
c291bmRzIG1vcmUgbGlrZQp5b3VyIGZpcm13YXJlIGZpbGUgb24gZGlzayBvciBpbiB5b3VyIGlu
aXRyZCBtYXkgaGF2ZSBnb3R0ZW4KY29ycnVwdGVkLsKgIElmIHRoYXQncyBub3QgdGhlIGlzc3Vl
LCBjYW4geW91IHRyeSBvbGRlciAob3IgbmV3ZXIKZGVwZW5kaW5nIG9uIHdoYXQgdmVyc2lvbnMg
eW91IGFyZSB1c2luZykgZmlybXdhcmUgZmlsZXMgZm9yIHlvdXIgR1BVPwoKQWxleA==
