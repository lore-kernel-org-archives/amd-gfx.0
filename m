Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0679F3092A
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2026 10:41:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6390C10E0E4;
	Thu,  5 Mar 2026 10:41:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gu2mxeQq";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011047.outbound.protection.outlook.com
 [40.93.194.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0468710E0E4
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Mar 2026 10:41:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NMuPiLpzwNSex/oBjAOacJal0suJcC9hL28MOMKjFeMQ1AIVN84I5+rRv+hNfqhDjFWzmL7mGnEF8TCLzq1pooyTcXxSC6FkpPDkR3AfTlTstL4EdoNkD1PgF50Oa4Js7s1qNSFGHx+RkUYbh6ayqom4Adxtr9DadNoIy2yyVXeH7EgcJIM8wwbS+S00uut6NnbEM4hKgnxPwdDlYGWMQDgVCPp84Y+MdtU6QwboE8lLwFSzWazDOVEtrKshn/9dJBU7UEw335KnFO50qgS3CvSXZ8LQAeXd70ELFau9+89audJ9elk/wDm1iNl84txwIDADCuT8Ubun+ShpdufWUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nEBh4Obs5QbOCwNk/vy9D3yVEaFpqwyE+QPjQ7tTIPk=;
 b=cWQoFRKjxNXX5sm+W8gXmxjSMZRPz6I7kleYfI12mWOY9rZRcvva0D1uWA4s27JvlOPtVC3LMTzKVWiClmAcP3iyQDaeAkpAWUuJSxmGIinUSwkbWCgfd7jRG8NVo7/8Uv1kuqBBkIE5twGPkCx2aHysBQMV5nBjFsqF9qz4wnsGGsMVIuDX6uloVYe20yJjQzmnDNmRyaaYEeUmKnU+WGIRK7dNe59fDoITI2N+vtZGqETI900nsri9LsSjGK2hynwfRpY2ADMNZatm3RoGBHRDFqEARpAwVJoGLsir0otJXHjN9cPS/sgzy/GObymz4fJ85MgDr459EnHb1qbQ7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nEBh4Obs5QbOCwNk/vy9D3yVEaFpqwyE+QPjQ7tTIPk=;
 b=gu2mxeQq5poeonoqUuuScXwd9DDzbw4+a33+kbHE7CCFNIkP9oxQbUzr8++LbqsuLK8/5c4j2yE5QiHGzdRF7j90z9WdEsUrKlyDhC2q9yiXuw/9HWbL3TU4HA6SLUgfOweVB9OcJ8JC+3mP5CJsJ+M9KayKCC7Sazs2Ct8esDM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB9124.namprd12.prod.outlook.com (2603:10b6:610:1a7::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Thu, 5 Mar
 2026 10:41:29 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9654.022; Thu, 5 Mar 2026
 10:41:29 +0000
Message-ID: <b2382958-0034-498d-be9d-b476b27fa43c@amd.com>
Date: Thu, 5 Mar 2026 11:41:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] drm/amdgpu/userq: remove queue from doorbell xarray
To: "Khatri, Sunil" <Sunil.Khatri@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20260303171111.92396-1-sunil.khatri@amd.com>
 <BL1PR12MB5753AE9D4D5B370D32242FFB937CA@BL1PR12MB5753.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <BL1PR12MB5753AE9D4D5B370D32242FFB937CA@BL1PR12MB5753.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR2P281CA0170.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB9124:EE_
X-MS-Office365-Filtering-Correlation-Id: 557a8418-4341-4c73-6471-08de7aa3c237
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: Xp4gVCD2XyWBFI6nW8/baHgWDiukrl7mdLlRwbCojsVMhpWw2snnSgdvMiDiF421qNam790/LDDYKmXwZxfvh2I2ERA+Bts8Knxi3aIJIhqXCuY6B+gdN93AMO+JHv/tgiIP0JZ/wq25pfW6dT6XlxLB1wIVfjNy3GgWrle+0jWhNlIy6MtJdAcwWViiYPGBBG+zM+NhDG78Q7f65xtBYzO1pCc521NYhIpfhLAs/7rV5PBcBUKWU2kIj4L2meeFwF9XTr2FZDfLAvUMD55C6SIFggBmxtEonqfYyZkWGTPkzsWrbrQcySFfU9pRDnfJd7qrEarnJbfF59lasVC140qWMgXpbg5Az/CexnlUSAErnL66uqRBjcfCHBcOHW6TCtlfivNfTscLIqgX/2prTRiu2vc0QTDRLZuqVxBgPfc0/WeSOtJTdqjUNkCk/u/k6tl+zFSxj37WWQjbqUC8lX69eIrNiKO9MZ2eF/Vuh8fNfrHFYhfi5hmnr10mR4+FVXugRGapW6bns+lewVZBHVVjJa9MQMQt8YvwnDnVHqhSMerbXz0Stvso0uMgO0vtkjFZJuWGKiBUGh3eR/c1rWlHwf1tvgAAG8zdjHCM9rEdJx0CoYKKLYDfoiEp0+6nnr9ss53ThqKmw4DjwvWOojn94/K17lhDa6aTayDb2TovCbxstauLCNGy+VGq8MqMP4p1mjNOcD+me53ojbdLxqcZzYFXXg2o6lQKNMire6U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHZQOXkxRjE1U2RSWkRpN0NIUm1hOEZYUjZDb2hKSzMrb1BtQ2ZnZnQ4bi9o?=
 =?utf-8?B?WUJKY3pYY2w1aUl5Ky9pZURsdEU1YjdzcFc0ek9ZUzBzeHB4YXlLSEJNbHlV?=
 =?utf-8?B?UlF1cEtNcjJVNVBDNXlERCtLVXZJQUpjQldzQk8xOVJ1a1JVYTRwbHl2d1lR?=
 =?utf-8?B?NWJVYUJnVVdKU3NrcHVFYlBoRGQxN3kvWXR2akkxNkR4QTB2SS81MWNMSzRH?=
 =?utf-8?B?cUs0MDZ4VEg1TE0wRTFBc1FKbUtSdVM2SGJFTzBtYnp1OWF0SnhRYTdjUEMy?=
 =?utf-8?B?ODJDTHBlQVEvOUJwR2lSUzExTUh5VjdXNzZiU2Fja2plT21nZkMzV1NpTTd2?=
 =?utf-8?B?V3NmbzBlRGZyVENPd2xrQ3B3SGRYZUpyRDRldmkwRG9xeHRRYVQ4RnJEbkh5?=
 =?utf-8?B?ckFBQ0Uxak9BMnE1ejR2a0sxK2NCN1ZnZkhQNnpGMmdMb0d3WmVWaDg2Wk1i?=
 =?utf-8?B?Ui93QUN3SXVaTkZGUkNRWk1LWEZnRWM5YXJYYVllaVhpckpNSjRYWlpKNlM3?=
 =?utf-8?B?RU4zMzhEb2RBTmRPY1dZeXl6QlNOZDVmUXA1ek1YY1p4TXZyK3ZhbENlS1Av?=
 =?utf-8?B?YXJnWEpGUTBLYStFd2RWY01hcTNtbUlzL09JMkRSMFpCekwrUzlRQmN0a29J?=
 =?utf-8?B?NGhySGNEcEIvdmN4elZhZUovKzd6QjNoeUhiR09qODdQc3htNUVwUWQ1S3ZO?=
 =?utf-8?B?a1ZlSEFpZmptY080M3dyZkR1Y0FxU3QydXQxK0ZNbTI4OG1rZ1UvcFFSZ3hU?=
 =?utf-8?B?UFNIQm1TaElGZ1RBUUVVTjhnb2JCWWJBMXozMzl5SHF4K1dmcXB6MWU4Q2RK?=
 =?utf-8?B?S3BvZVZCK2MyZEwxQUZSdkp2L0doU21xcE95VEtSMVRXbWthOW5zSGoxWmNJ?=
 =?utf-8?B?QmR2TzBqV2ZDNi9Nd21xWnJxV1F4TzJhbXdKSVkwNXA4T0dPTEVLYU1ySmk5?=
 =?utf-8?B?MWViVi9Na001enBrbTZRSnl6UFFZVktzRHhtUEd2VEdoTzBLNkdneFBrTWhS?=
 =?utf-8?B?U00yanZiWUVycEh1aHFSS1VHMUNPS1RqMTBDdnJhdEIxMzBpbXI4SWxOT2R1?=
 =?utf-8?B?WWxYSC9GakFtbG1QT1g1d3p1WGtZdXpDbkhCNkczWHdWK1VWVmNvK3p2bTEw?=
 =?utf-8?B?UXE5SlV6eFBwdGlhMlZlVnNwOVhZblhTNTlSTEpsZWtKYi9DYlRDWHZsT0lJ?=
 =?utf-8?B?M21aZVM0dG9lT0tKMWozM2o5dnozUTZDU3B2a1ZtU05aZFc3am0zYmhWSWF5?=
 =?utf-8?B?S0EwSU96VXpiUlp6US83NnAxZENzZ1RhTHR6S2s3WjU4bFJRcm9IV1RDc1cx?=
 =?utf-8?B?U0NkcUJmOXNGZEVFZWxDMXVnK2RQenZPMGxhNGxMUTZGdzZOU25DNy9pNU5r?=
 =?utf-8?B?WTlEdVRua285Mjh6OHdlSDZOK21TLzMyaG1FblBCdWl5cnpMSzRQT0RQVitB?=
 =?utf-8?B?bzZQeE1QRFFFMzd1TkxiV2JQSVNhZ0pnVEJRMWRKOTBENkNLSWgxWTcrR0Rr?=
 =?utf-8?B?WGVlcHVxUG5EdUhoaVF4ek43T0dUWCs5cDV0WXg5cDNQNDJld3p6MzFORWVL?=
 =?utf-8?B?SkRpMXhKeXlMSVIwRk1kOFlwcGo3M0NzWnNFeVlEZzZqSTEwNnVtU2Jid2dP?=
 =?utf-8?B?Ry9nbjRQbXNwQmxOWUVMMUE2T1hDNzVaK3QrTEtZdWY2WEx2TExpK0gwcmpY?=
 =?utf-8?B?cmNLb0hIYkVVWHFackhMZ3lydUVoNEt2eXRYM0c0MjhVS1pVeTlNUWtFeW4v?=
 =?utf-8?B?dlEvaVF4Y1hMVVVwMDVGZGRXcE5QTFpydEt0LzFnR1hpZnRLYW8xYnVyRm91?=
 =?utf-8?B?WXZyQklvRUl3K2xLUEtnQkwxK3A4bWZ5REcxYXRDMnNjSG0wN2JIZENURjFx?=
 =?utf-8?B?dnJQY25WSEs1S2RhZjlhRE55ZUwyQi9KdDliK1lpRWQzWTZONVRyRnpremo3?=
 =?utf-8?B?dWVNa2dTNW9HNWJZWmozbGNyNVRwUURmdkl5SjhYUnFYTGdiN1kvSkV6dGov?=
 =?utf-8?B?YmZUZzRlaFViVkd3TXMyU0g4dGswd2piL2QrejRvNUNDTDM4WEQ3S0hHQUt2?=
 =?utf-8?B?R2U0UWMrUlNOWkhXejMra2Ezc1FoZ2xRN2lXRU8wclc5a2RvUjRhSFJPRWVX?=
 =?utf-8?B?bm43eGpQQzdHNmV6Z003c0ZFY2VPS2VDcWk1b1I2VmxVcTRFbUNxYTc3SEhi?=
 =?utf-8?B?VFVRZVZwQXZJcExYYUJ4Vmd0czZ0SVJYUlV2SzZvVHg1dmxXekpBM0Uramsx?=
 =?utf-8?B?b3NiV2o3THhkSFdwbHplTnQrUXcyUkp3cW9pZzNjUENoQmRicllyaHk3ckN3?=
 =?utf-8?Q?oZFm68LoYCAuOV5FLv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 557a8418-4341-4c73-6471-08de7aa3c237
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 10:41:29.1331 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pBg6dfkF5qUCh88duUA5Bm9XXVZ0IE02HH7+WY4PpH0Btbfea6MFnJTONKeWJI1g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9124
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

Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com> for both.

On 3/4/26 14:09, Khatri, Sunil wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
>=20
>=20
> Ping
>=20
> Get Outlook for iOS <https://aka.ms/o0ukef>
> -------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
-----------------
> *From:* Sunil Khatri <sunil.khatri@amd.com>
> *Sent:* Tuesday, March 3, 2026 10:41:10 PM
> *To:* Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <=
Christian.Koenig@amd.com>
> *Cc:* amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Khat=
ri, Sunil <Sunil.Khatri@amd.com>
> *Subject:* [PATCH v1 1/2] drm/amdgpu/userq: remove queue from doorbell xa=
rray
> =C2=A0
> In case of failure in xa_alloc, remove the queue during
> clean up from the userq_doorbell_xa.
>=20
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
> =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 1 +
> =C2=A01 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index 001fcfcbde0f..5224871a099c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -865,6 +865,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_=
amdgpu_userq *args)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (r) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 drm_file_err(uq_mgr->file, "Failed to allocate a q=
ueue id\n");
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 amdgpu_userq_fence_driver_free(queue);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 xa_erase_irq(&adev->userq_doorbell_xa, index);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 uq_funcs->mqd_destroy(queue);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 kfree(queue);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 r =3D -ENOMEM;
> --=20
> 2.34.1
>=20

