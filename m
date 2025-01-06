Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABBDFE77198
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jan 2025 01:45:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C19A10E192;
	Mon,  6 Jan 2025 01:45:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zLvQsWX6";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 675A610E192
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jan 2025 01:45:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O2MIRnGjKpkw9/q9XfZqeADXnimZoUUL336mvEzBZ8yHICP5hVhkHV4Dc26edXX2s6Z5DwFAfZfyk46aVUS+mlgudcr9rB1lAyq9UZT2sGCLRr+qJkPscg4MS5XjwnJ9D9pYmzw0KBaLaNP3/tzmJZrfo3bKETYjX8Ciju7gYbssfAT9u32G+HgiINsJA91EwaGRznLbxMd6s5srpmH5/N0Iw2MDhZNztd0H/Z5XBRX2jAFQ7m/pdoZaAybj6KYGDb6ON8Y2016evJrJ07GUC+lBs3Mq1lawFz/fIInZxIgCfuEa/1kWxBNE42d8sE9fka1QzPwZwJvJd7A74KcHog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5WVY5W4/Dx1ARZV/4ScEbv2k4w6ymS6IIygarjGvUf4=;
 b=kBsrlelbhVvO5j7tuzcXtRCdQ6t/evfO1tW/drj90DekZtmb2F4EzZWbV7xuRYl2Fu1y7QwRoQYIBHmBoKgPeasnveZZcb74qYta1/hoIPS9k9VowPl2aBLegjRtQ5h9Lvi45pbfFFJsgjnzEvSdY2tI47jk8B2udO1WKTW5pPvPvDMig1v6Ug1upUL8joPXGCtv8/xZnLUqQZ7Q1hgZd7CTpNQf7DepVOFM40n7AM+GXja9mKNmlBWDcz7r46qHJgUxAyeFrnpTwNcXsnC9a4DcBMxksbERPbhruacy5e1vAsiMnd6L2WhgqaFu7UB0LJQHF2ASkWvrDjecVMWTQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5WVY5W4/Dx1ARZV/4ScEbv2k4w6ymS6IIygarjGvUf4=;
 b=zLvQsWX6mrLCdI//4wc267Ba5v++G87mZ+EqXhyRw1N4Jko/6dLnoAZuH4/uGz2o8e42a2kWuR8LAOpeGeRkHcV5MDScaSHmMswPVvpExs46d22oMQzWJJ6NA04bvItp+PFFQUzh32U0zF/eFBID5eanuM5trGbPE+SCAMbvzpc=
Received: from PH0PR12MB5417.namprd12.prod.outlook.com (2603:10b6:510:e1::10)
 by DS0PR12MB7656.namprd12.prod.outlook.com (2603:10b6:8:11f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Mon, 6 Jan
 2025 01:45:15 +0000
Received: from PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::de07:ec43:e847:2f50]) by PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::de07:ec43:e847:2f50%5]) with mapi id 15.20.8314.015; Mon, 6 Jan 2025
 01:45:15 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: Fix partial migrate issue
Thread-Topic: [PATCH] drm/amdkfd: Fix partial migrate issue
Thread-Index: AQHbXXNmg3btm0VQfE6EJOJsqvbedLMFrkCAgANPGwA=
Date: Mon, 6 Jan 2025 01:45:15 +0000
Message-ID: <PH0PR12MB5417768A1EAFBB5BCFFC85BD8F102@PH0PR12MB5417.namprd12.prod.outlook.com>
References: <20250103000644.1398643-1-Emily.Deng@amd.com>
 <4af83c37-0a9b-4b15-bfdd-6b8511b93a36@amd.com>
In-Reply-To: <4af83c37-0a9b-4b15-bfdd-6b8511b93a36@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=39628b3e-d530-4348-b612-0541895260bb;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-01-06T01:41:39Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5417:EE_|DS0PR12MB7656:EE_
x-ms-office365-filtering-correlation-id: 647b05d7-ae0d-4604-3412-08dd2df3c4bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?RnY5RmV6eFQrWEt6SEtZMjVKYlhsOHhGZVphZVQ0WjdoREhoakRFTlNoVlYz?=
 =?utf-8?B?dUl2QU1OM01RZzlTQW9QTXNsVE45MjlaRlZpU3lKTDIrdFpGSTUrbmliUVJB?=
 =?utf-8?B?M3FnNXN1d1ZUdExnZGpWTG9TU2o0SkZmMHc2anJmQ3U3VzJwZDFhTnpzZXcx?=
 =?utf-8?B?Y2g2eEp5M3JEcmR6VmRMZG4wT1E1eHVjSWw4VldkMTdXa2d5ejRGT21VdFVI?=
 =?utf-8?B?YkNmOUhUMWVCam1JTWgxRU5aOUkxNjBrTDh1cExTM1E1RW0zdlM1LzVXcFhG?=
 =?utf-8?B?THo1TjUxeVdvbW5ZUkIray85N1Y5TUtvd0NUbVl5ODlXQUM5M1ZncmlzVGh2?=
 =?utf-8?B?cmVOWDdxVG5GMTdhQmFpaHRKQlVjaE9BdzBpbFoxTzkxT2FGWkxKYVV0YnVw?=
 =?utf-8?B?aDNSa0hQYWI5cnhzRDE3eXJZWTA0R2tnVDdXTjNHN1J4RitQVjVNbFdFcWdi?=
 =?utf-8?B?ZjlIelI3WVIrVUNaSThNVFBhZzRUNzN4azVTaVZHUUJZSTFLR0k0Qk9PMUFa?=
 =?utf-8?B?TWd2REtKeEdpQmdndnpCRHo2WFhtSnpQMmpadFlxeWk3UzRMWi9TSDFGTzI4?=
 =?utf-8?B?U1FnUTVHRmZsSkJnVnNEUWwxTzdtUk4vTnV3T3duVU8vb05uMWo4U2xtckF2?=
 =?utf-8?B?THN0QUg3eTVnTkFwL3cyMGpxODhibkNmU1dKRFlxWkZnY0t2TE84RnNGblZj?=
 =?utf-8?B?Y3QrWXVLNXg5RGtvMjU4MGVhUExyQzUwY2FjZTRzT0xVS2pveThIMitFUW96?=
 =?utf-8?B?dXh5SUQ4a0g2ZllISVl2RndTTitwY1Z0WVpUNjFCanBZK3hjRm9wRSs2azll?=
 =?utf-8?B?YTVQWS9vQkZOS3V2UE42ZjhQdTBWLzU1UVE2dVQ1TTFIRlhyT210U3NQRGNs?=
 =?utf-8?B?V2I0TjRVODMvOUdKLzJNTzBMY0FaUE1vMEh1WlY1Z2JKTWp1M0tpUkdMYXBC?=
 =?utf-8?B?c2RiSnhRV0tNdng1ZWlzOG15UzMrWnU3NXAxTE01cG1QQWpMU0RjdlVqMnZp?=
 =?utf-8?B?QjNwMk5hSW5KdHNOeTR1WXFZTEY1Zlc0amZqcmdNMG1vZ1ZlNzhlZGNhT3Ft?=
 =?utf-8?B?ZFhZbDhITjh3VWhoM2xMOWJpT0JQTHdCVWlnVi91V3d0ajJQdTMwK2JiR1dj?=
 =?utf-8?B?Z0pyNjNOUjU1aGNLYkNBVGRJTEdhZ1cyN1FoUWtrblpxWXc0S2xEdzZNRkZy?=
 =?utf-8?B?bXpLTGZlYVJDZVRuYXgwdnpmZSt1Mkg3RjBoRUFlRk1VQm5wSjlFVmVvTHhU?=
 =?utf-8?B?Rm5YemhjY1ZaL0lUQ014cFdzMFV1TEZ2QlFyRTRMTU1hbktpbkFqM3JRZ0Nh?=
 =?utf-8?B?ZGlOTkZSeWI5cEdDV3VsM24zdUJPZ0hYMkduTW00NW5pY1I5djFZdWtwWUQ3?=
 =?utf-8?B?bjVWNjFZbG1LaC9GVS9Rc0VHUDJidHJBZDhRdXhqaktGMzhPTHptUGJYVS90?=
 =?utf-8?B?YmRGSEVUZXFaT2tPbnhZcnZsSzNYRlZmakVOaUlncGVWUW9IWVV5aTIyWU0x?=
 =?utf-8?B?a2JoWCtGZVFTdVoySDZvVk1JVnpiMnJYTWw0WWt3aHA4T0srUkRHN05QNzYr?=
 =?utf-8?B?OVBrRUdWcHJ3Q0kwVUpvcUcyNWlRVy8yRXVtUlJUOXpoV2lJOUl1d1VJaDJx?=
 =?utf-8?B?RDFzbGg0SVVESWROOWljcjFZeVJMdFJuTWdoR3hmYkgrWjZPQmdYQ1RJY0k1?=
 =?utf-8?B?ZnVRa1gzbzRZc3VkdkhMK3JCMXdFamhjSWtpeXl5WWc5VEpLYW0xV3BUakVH?=
 =?utf-8?B?QzN6Z3B4K3kzWnBKOEppSDFhRmhoYTJWQnRiY0tiaTRoa05ZSXQ2U2NJUGZN?=
 =?utf-8?B?WFBpWUFXVUprRlhSZjl0eHRjSmR6ZUVyQVpYUEJpWkF3eTVlV0dUR2U3VjJQ?=
 =?utf-8?B?N3RWWkhCMk8wVlpVR2lKSExsQ1NWbHpUei9FOHRDQWlXTlYrcS9wdnJ4TC9n?=
 =?utf-8?Q?XWyOymTa3U7fveLXJz5hrGkhMvVVd7S1?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5417.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MlNnM0FqOVpCbExPMDBZSUluNGVjYWY5c0VhN1dpVmZVY3JyMllES0lIbjBx?=
 =?utf-8?B?YThZY3A1dm9YQzJyZzRYSFJ2dVNYR0Q4Vk9HcUJML3Nqcm5lVUcrZmpoU1Y2?=
 =?utf-8?B?V1REeDNMVXdSTEI3c2MrVUVNOVkzZW9HYXB3c2xJREVuNnJpTTczYVl6aVFt?=
 =?utf-8?B?Y0RHeVcwMUxidmh1Z0E3WFdIMVRORkZNL3FRR1cvNjZWRWNrMFA2SU1WejdX?=
 =?utf-8?B?UWEyTC9FWUdaUVFKNTR2YWdNVTFQQzNSczdSMi9PeW5ZQncxZFJ3eEFGYXZz?=
 =?utf-8?B?VHR5UHZoSkcvZ1NsbGtJQ2p1YklncGpGVUszb0lqdWNqVUpCczhjR1pHM1Rx?=
 =?utf-8?B?aHpOSVI1NzQ1VnIvK0NmL2VMOVhwY1ZkTE5HbEhhK056VnVDTllzbHJYa1Ux?=
 =?utf-8?B?QWN4eHdRS1ZLQ2hjU0N4aXNIMGpXdkhhUThHaERBNVQvZlgxWmEwUnovVUMz?=
 =?utf-8?B?RTJFRksvQ2lHRmZ3dnRKSXRMSWdWR25oOVFpZ3J6ZGFVTHhpOXdsdS9Jc3Bi?=
 =?utf-8?B?c3FxZzRTdXhXQmZEUUFTRHV2Ui9Wekp6SlNiaHpZd0NUVVM3SUNFUUF4MVIz?=
 =?utf-8?B?bnM2ZlpvaHMzcDQ4RHpxUDdQemsxU1RGL2FiR1FFMkRMQTlYT0hRbU5obXNB?=
 =?utf-8?B?eWc3Q0FIeURkNjE3ZEQxTlZ4VFRpaktXZ0krbFpIc0ltN3I3cW9XMkpTcFVu?=
 =?utf-8?B?M29RbGFqVHFQUjNKQW1JN0NlNWhlUkkzaytmYm9PQ21nR2lnWXVmU0ozV2N6?=
 =?utf-8?B?TjRMbGRiL3MwS2hGYlMxMWJXQ0JxRFhpdC9HY2hiYjZpdk53L0x6RWJoQWcy?=
 =?utf-8?B?QkFmdmR2cjNuZjBXMDUxcENLNlJNTFpMYkxkcFVhbzdKb2Z1MDdweDZWWWZy?=
 =?utf-8?B?NkpXVkdYQWsvdWFtRXN6QjVCbmZNTjNneWRlWXJzQWYyWSt2ak1BSDhMV1Q2?=
 =?utf-8?B?MlVBY2dHL05MVDFSSFFwMHl0ZTMxWVBVSTR6RllHeS9TUWhhU3lhWTdLVGQy?=
 =?utf-8?B?Zkx3bGVNbkFXb3k0dEpNK0h4VVErdFVTdUlpSERXRjczRVIzZEVmTTMrNW9k?=
 =?utf-8?B?dXh3NGQvM0pCQWEzT0VDSWZZT3B5b25MTk9yazRlblhUbk5MYWo0N1hvV0Ft?=
 =?utf-8?B?am1IbzZxZ0pTQWV3b3JsN2JiUE5rdUlLMXh2eEJ0NkMxT2xMSGMzSVRORXNn?=
 =?utf-8?B?M0w4aC9BRG9ySVFTKzk2dWtaWXhzMDU2ZDFiRkppTmIyODd2Y2tNNHdidDMz?=
 =?utf-8?B?bzNKWllkZHUwdVBsZklnUENLV05pYXlxK3I2YXVSSlhNVUhTbjlJYzZZdGFI?=
 =?utf-8?B?Zjl1aXM1M2Y4RTJtUllkVDEyT0Z5V3BWSWQvakY0b3gzYjlPWnJjdU41b3dY?=
 =?utf-8?B?Rld3ckpCY0hmNThZOVEwNjhqc21KeFhPdGhZTWRLdkpQclI1MGlTK3RNMUUz?=
 =?utf-8?B?M1c4NnBzd3hxa2llSGNNWis2TEU5OWpqdGthOGdvWVFubnh1dzhwckNZUzFs?=
 =?utf-8?B?WnhYVUI2b0JiYU1iMEtPUDZWTzhXR1V6STVFZzVNLytGM2ZHMHh5M1d2dEZy?=
 =?utf-8?B?dTFLSVI2ODN0MlhIbHNvdkhIT21HbzRNM0JTOGJteGpKMndHQTlQZk9MYWlZ?=
 =?utf-8?B?VS9sUUZsRE01ZEJXRGhoNG9iblNFWEV5N3hNdWFiUmlGWG1mV01BTGhadmNN?=
 =?utf-8?B?RlM0MUhWVEJ0NnVXalgrZVBRVThoZi9rSGY1bW9laXY5S3VqcURvd0hTaEhK?=
 =?utf-8?B?Y0VFOVJWbjBIVnZQY3Q5ek1BSkhLSEZFWkhzQ1hWTDE2Q2VFTTZxM1lNdkp6?=
 =?utf-8?B?a2FydUZtcDFiWEhtWGxWQ3FoS3dHY2JpOUhqUXJUTEhETTVEbnB0RzFMM21T?=
 =?utf-8?B?bU53ak9tVWxkY1p5M0Fsb1Q1bmF0UFlvYkJEUWtqbUM2SFFxQUZoOXJ2b2hk?=
 =?utf-8?B?NTVUbFE3R0xOd1JRZkVKSkdqaGc4V25YTlBDZm0wVEd3ajJyN3dnaFdtRnNF?=
 =?utf-8?B?TERvTVA1UE1SUk5jd0MyNVpncFl3RUtyQnJ6TGh6ZW8rbFlXd2t3S3VibHh5?=
 =?utf-8?B?SndBSUs3c2pSLzEzUi9ValNjQTRkTFUrSHVEcjdMcFVpZ21tNHFrbHNHZHZX?=
 =?utf-8?Q?rogc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5417.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 647b05d7-ae0d-4604-3412-08dd2df3c4bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2025 01:45:15.7112 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GV+s6iT3Txi0/WaW+RE/DlU5wpSuixARvFc1d2QWi1VyX4hSak4dYVk9jGWgMGSc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7656
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogS3VlaGxpbmcsIEZlbGl4IDxG
ZWxpeC5LdWVobGluZ0BhbWQuY29tPg0KPlNlbnQ6IFNhdHVyZGF5LCBKYW51YXJ5IDQsIDIwMjUg
NzoxMCBBTQ0KPlRvOiBEZW5nLCBFbWlseSA8RW1pbHkuRGVuZ0BhbWQuY29tPjsgYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcNCj5TdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1ka2ZkOiBG
aXggcGFydGlhbCBtaWdyYXRlIGlzc3VlDQo+DQo+DQo+T24gMjAyNS0wMS0wMiAxOTowNiwgRW1p
bHkgRGVuZyB3cm90ZToNCj4+IEZvciBwYXJ0aWFsIG1pZ3JhdGUgZnJvbSByYW0gdG8gdnJhbSwg
dGhlIG1pZ3JhdGUtPmNwYWdlcyBpcyBub3QgZXF1YWwNCj4+IHRvIG1pZ3JhdGUtPm5wYWdlcywg
c2hvdWxkIHVzZSBtaWdyYXRlLT5ucGFnZXMgdG8gY2hlY2sgYWxsIG5lZWRlZA0KPj4gbWlncmF0
ZSBwYWdlcyB3aGljaCBjb3VsZCBiZSBjb3BpZWQgb3Igbm90Lg0KPj4NCj4+IEFuZCBvbmx5IG5l
ZWQgdG8gc2V0IHRob3NlIHBhZ2VzIGNvdWxkIGJlIG1pZ3JhdGVkIHRvIG1pZ3JhdGUtPmRzdFtp
XSwNCj4+IG9yIHRoZSBtaWdyYXRlX3ZtYV9wYWdlcyB3aWxsIG1pZ3JhdGUgdGhlIHdyb25nIHBh
Z2VzIGJhc2VkIG9uIHRoZSBtaWdyYXRlLQ0KPj5kc3RbaV0uDQo+Pg0KPj4gU2lnbmVkLW9mZi1i
eTogRW1pbHkgRGVuZyA8RW1pbHkuRGVuZ0BhbWQuY29tPg0KPg0KPkdvb2QgY2F0Y2guIEJ1dCBJ
IHRoaW5rIGl0J3Mgc3RpbGwgbm90IHF1aXRlIHJpZ2h0LiBTZWUgaW5saW5lLg0KPg0KPg0KPj4g
LS0tDQo+PiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9taWdyYXRlLmMgfCA4ICsr
KystLS0tDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25z
KC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9t
aWdyYXRlLmMNCj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX21pZ3JhdGUuYw0K
Pj4gaW5kZXggNGIyNzU5MzdkMDVlLi41Yzk2YzJkNDI1ZTMgMTAwNjQ0DQo+PiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfbWlncmF0ZS5jDQo+PiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGtmZC9rZmRfbWlncmF0ZS5jDQo+PiBAQCAtMjc4LDcgKzI3OCw3IEBAIHN2
bV9taWdyYXRlX2NvcHlfdG9fdnJhbShzdHJ1Y3Qga2ZkX25vZGUgKm5vZGUsIHN0cnVjdA0KPnN2
bV9yYW5nZSAqcHJhbmdlLA0KPj4gICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBtaWdyYXRl
X3ZtYSAqbWlncmF0ZSwgc3RydWN0IGRtYV9mZW5jZSAqKm1mZW5jZSwNCj4+ICAgICAgICAgICAg
ICAgICAgICAgICBkbWFfYWRkcl90ICpzY3JhdGNoLCB1aW50NjRfdCB0dG1fcmVzX29mZnNldCkN
Cj4+ICAgew0KPj4gLSAgICB1aW50NjRfdCBucGFnZXMgPSBtaWdyYXRlLT5jcGFnZXM7DQo+PiAr
ICAgIHVpbnQ2NF90IG5wYWdlcyA9IG1pZ3JhdGUtPm5wYWdlczsNCj4+ICAgICAgc3RydWN0IGFt
ZGdwdV9kZXZpY2UgKmFkZXYgPSBub2RlLT5hZGV2Ow0KPj4gICAgICBzdHJ1Y3QgZGV2aWNlICpk
ZXYgPSBhZGV2LT5kZXY7DQo+PiAgICAgIHN0cnVjdCBhbWRncHVfcmVzX2N1cnNvciBjdXJzb3I7
DQo+PiBAQCAtMjk5LDkgKzI5OSw2IEBAIHN2bV9taWdyYXRlX2NvcHlfdG9fdnJhbShzdHJ1Y3Qg
a2ZkX25vZGUgKm5vZGUsIHN0cnVjdA0KPnN2bV9yYW5nZSAqcHJhbmdlLA0KPj4gICAgICAgICAg
ICAgIHN0cnVjdCBwYWdlICpzcGFnZTsNCj4+DQo+PiAgICAgICAgICAgICAgZHN0W2ldID0gY3Vy
c29yLnN0YXJ0ICsgKGogPDwgUEFHRV9TSElGVCk7DQo+PiAtICAgICAgICAgICAgbWlncmF0ZS0+
ZHN0W2ldID0gc3ZtX21pZ3JhdGVfYWRkcl90b19wZm4oYWRldiwgZHN0W2ldKTsNCj4+IC0gICAg
ICAgICAgICBzdm1fbWlncmF0ZV9nZXRfdnJhbV9wYWdlKHByYW5nZSwgbWlncmF0ZS0+ZHN0W2ld
KTsNCj4+IC0gICAgICAgICAgICBtaWdyYXRlLT5kc3RbaV0gPSBtaWdyYXRlX3BmbihtaWdyYXRl
LT5kc3RbaV0pOw0KPj4NCj4+ICAgICAgICAgICAgICBzcGFnZSA9IG1pZ3JhdGVfcGZuX3RvX3Bh
Z2UobWlncmF0ZS0+c3JjW2ldKTsNCj4+ICAgICAgICAgICAgICBpZiAoc3BhZ2UgJiYgIWlzX3pv
bmVfZGV2aWNlX3BhZ2Uoc3BhZ2UpKSB7DQo+DQo+V2Ugc2hvdWxkIGFsc28gY2hlY2sgKG1pZ3Jh
dGUtPnNyY1tpXSAmIE1JR1JBVEVfUEZOX01JR1JBVEUpIHRvIGNhdGNoIG9ubHkgdGhlDQo+cGFn
ZXMgdGhhdCBhcmUgcmVhZHkgdG8gbWlncmF0ZSAoaS5lLiBub3QgYWxyZWFkeSBpbiBkZXZpY2Ug
bWVtb3J5IGFuZCBub3QgcGlubmVkIGJ5DQo+c29tZW9uZSBlbHNlKS4NCj4NCj5SZWdhcmRzLA0K
PiAgIEZlbGl4DQo+VGhlIGNvZGUgIiBpZiAoc3BhZ2UgJiYgIWlzX3pvbmVfZGV2aWNlX3BhZ2Uo
c3BhZ2UpKSB7IiBpcyBhbHJlYWR5IGNoZWNrZWQgd2hldGhlciB0aGUgcGFnZSBjb3VsZCBiZSBt
aWdyYXRlZCBvciBub3QuIEJlY2F1c2UgYWZ0ZXIgY2FsbGVkIG1pZ3JhdGVfdm1hX3NldHVwLCBm
b3IgdGhvc2UgcGFnZXMgY291bGRuJ3QgYmUgbWlncmF0ZWQgaXQgd2lsbCBiZSBzZXQgdG8gTlVM
TC4NCg0KRW1pbHkgRGVuZw0KQmVzdCBXaXNoZXMNCg0KDQo+DQo+PiBAQCAtMzQ1LDYgKzM0Miw5
IEBAIHN2bV9taWdyYXRlX2NvcHlfdG9fdnJhbShzdHJ1Y3Qga2ZkX25vZGUgKm5vZGUsIHN0cnVj
dA0KPnN2bV9yYW5nZSAqcHJhbmdlLA0KPj4gICAgICAgICAgICAgIH0gZWxzZSB7DQo+PiAgICAg
ICAgICAgICAgICAgICAgICBqKys7DQo+PiAgICAgICAgICAgICAgfQ0KPj4gKyAgICAgICAgICAg
IG1pZ3JhdGUtPmRzdFtpXSA9IHN2bV9taWdyYXRlX2FkZHJfdG9fcGZuKGFkZXYsIGRzdFtpXSk7
DQo+PiArICAgICAgICAgICAgc3ZtX21pZ3JhdGVfZ2V0X3ZyYW1fcGFnZShwcmFuZ2UsIG1pZ3Jh
dGUtPmRzdFtpXSk7DQo+PiArICAgICAgICAgICAgbWlncmF0ZS0+ZHN0W2ldID0gbWlncmF0ZV9w
Zm4obWlncmF0ZS0+ZHN0W2ldKTsNCj4+ICAgICAgfQ0KPj4NCj4+ICAgICAgciA9IHN2bV9taWdy
YXRlX2NvcHlfbWVtb3J5X2dhcnQoYWRldiwgc3JjICsgaSAtIGosIGRzdCArIGkgLSBqLCBqLA0K
