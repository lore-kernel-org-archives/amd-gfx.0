Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFC78EF5861
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Feb 2026 04:32:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 549F010E210;
	Mon, 23 Feb 2026 04:32:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fkG3Fl4S";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012041.outbound.protection.outlook.com [52.101.43.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED4F910E210
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Feb 2026 04:32:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TBGLIDekva5HBtW8BYx70iC2+IZtqr5ESIriSWwHfh3lu8QIzVqhhJRrDwBykfXQjXvH8XOyBaEeoXIwGOdY2OL/a1yLgVEBvF54G8qQkdfSvslM/fCVxp2BCUWHQMx/xzKPtqMPJlQCS7xhs7M84KNDVBA5jaWfnNPyLgQ5pa+L6sMiNygmrsXxwS3N5Z8ehSJ9VxMXabUAY0a9isssLGwaeHJgRoyFE7aeT07yXJ4boUmxYiQudTxon3es+yUSWJyew6Y9wyOt2HuXTpxLL++gzvcrk/tFJqXxQRY3LcpTGf3bUnMvbmgw2xExbZ/3HUWAG8fZRJ82aCSYelh/Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U54DywEqbFKEQ9dkWZ+AlXUooAqlNKWIoH9X22AT/8U=;
 b=msq+FrXpjZ+df9esoQAq04eTVAxt3KVDLY/TfBY8jtePt0oaGA+yn2+N8qUhhgOMqbzddlNDkAAFOKfyi9RwRvdwSPRz1Z3n1iOyo2fdgtkqa2w0LfpyjIi5nrXr5SrOTIg7Sg5t6R2+j0JHMH2UcWyr8L3ZH/SB3thM7QJo2v3FXCTKbHp0g22EeyrykyZWcsFQideCJvRD6R2QLX1/gi3A1CUvNBbXhLwgWLSiKPd23rX303009l4r5PABxeoKAQSRLlIE1XNYCArfrN81sIC2K6gXS0w9R5isebSs5WLG4ialpNFhl8D3HSCZPvZ0kWRquJmQ6jxzxKBA3+h+8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U54DywEqbFKEQ9dkWZ+AlXUooAqlNKWIoH9X22AT/8U=;
 b=fkG3Fl4SAJztRbl+6Q6IoXaPyQvI9zWpBZCwj8CCydYuvwwjtMwoiLVt4AmMSPKoYv4W8YEujzzdbqwZgkBYK5CNqvplhLC7iiG/2Ro/gFlZjYuhN8lTdznSVXZN/Wpoo+7fVny4DtgwNqBOCtEXpkMeksH/QciOrFKh1aop5cs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 04:31:59 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%4]) with mapi id 15.20.9632.017; Mon, 23 Feb 2026
 04:31:59 +0000
Message-ID: <3c4c8c6c-5bcd-426a-bd39-fb24db8fc5f5@amd.com>
Date: Mon, 23 Feb 2026 10:01:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] drm/amdgpu: update memdup_user with
 memdup_array_user
From: "Khatri, Sunil" <sukhatri@amd.com>
To: Tvrtko Ursulin <tursulin@ursulin.net>, Sunil Khatri
 <sunil.khatri@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260220082840.2192325-1-sunil.khatri@amd.com>
 <3c7f24f3-d1f7-4724-bf2e-8540fa2e2648@ursulin.net>
 <4a824f5e-5279-4cb7-b6a9-fb4c6f87cd91@amd.com>
Content-Language: en-US
In-Reply-To: <4a824f5e-5279-4cb7-b6a9-fb4c6f87cd91@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0132.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::16) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|SN7PR12MB8059:EE_
X-MS-Office365-Filtering-Correlation-Id: f296f2c3-c2c9-41dc-7467-08de72947b9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dlErNTAxZGs0NWhZNVJmMlovMEFlaFZpR3paWnVZVC8zd2I2UGJqa2xENnhN?=
 =?utf-8?B?RXA5NWlpdkVaZTB0Rk5FUm5iSjJCMUlEcXQzeUdWOFYvWXN1bEEzcFVMZmp6?=
 =?utf-8?B?RExTbkZEWXVNdUVTYitPQVVtMkE0OXhNeXQyY0FTeWJCczBnOGtrblV0UEZy?=
 =?utf-8?B?d0ttSEwwdnNoSnZXYkVZcEc0OWV5V0hXRysrNDllSjJQYlBIODNXM1JxRjFm?=
 =?utf-8?B?WFZvR3Yyby9DZC9EM0dKNGM2MHg4UFJlV1BEMFR3Z1NyZ0JtSVBaK2tGZWxw?=
 =?utf-8?B?VGh3QWZlaGYrZWsvdHdGNlpWbmVPbjZnVDRPUWVSbkxZRlFJcWJwWWRlcjNs?=
 =?utf-8?B?RkdwTEpNNHRJYXdpYS9keHNjMkhaem1JaDdaSXpBZ0hkYTV0MU1sb204UjZp?=
 =?utf-8?B?OS9VTjNWRU92M01xemVFakJJSHRNd2R1WW5MV2U2dGl5U0s5enFKRHNkaWNu?=
 =?utf-8?B?VmNFNFhPODN2YndjSnNtUGYzSUFaWVF1aXA1WjZ1QWQyZHp0Z1ZhampyNHJ2?=
 =?utf-8?B?ZTRGUkwxSEl6UmJwTkxzaXEyWGZYWVJoK0g2ajBzQnY0bks2MytvVmVmaU9B?=
 =?utf-8?B?VG1GbXZEdTV0aDhvRlRLWkc0bjZNSUM3MkN6Sng0dE54MzAwTXN4eks4bmt6?=
 =?utf-8?B?U1ZlNWZ3eXRQOFhGa3FEeE9HbHlSa0U3V1dnQ1B0cHAwVDBqMzRwVStkNXd6?=
 =?utf-8?B?WC93TEpqeUp1REhxMWQ5a3E2K0kra0I4NWNpS0l5b0xoZjkvSC84ZkVCa0tu?=
 =?utf-8?B?dFZJeWxKNHppMXNDb09jZUdVa3owcStaN05xTEdTTXRpZGNRVU16ZWU1OVVy?=
 =?utf-8?B?c1VFOFNkYU82WXcwZmVHQ0JkcUZuT3pOMC8xK0dObEV6UHlnUFB4QldUOVUr?=
 =?utf-8?B?WXdQeG9icXpMdUMzQzN4NUdKL0VCR0NZekhFczJCNnQyZms0TlM4L2JxNjhS?=
 =?utf-8?B?elhFKzlBM2lYbWNjc3ZKd0pIdHNyaFMrRlcyRnJSTDJleGdLZ3REUUkyY0pD?=
 =?utf-8?B?L3VTeEpoYVJibWd2TGVsRW1CbDNVN3dkSVNPdVZ6S2V4OTRocXF3UFowUzRH?=
 =?utf-8?B?WUFuWENRSmI2VndVL0tWQkhLd1JxSTE4NmVneFBtY1ZqSkNnQzBJYWNuM2hm?=
 =?utf-8?B?UnF2R2VmYk5NMFMyTGxIeHlTdE11c1RxVTczUVdFT08wVS9CRU56ZFRyOTI5?=
 =?utf-8?B?Q2FpQWFCbkxnQzE1dlUyY3M1UnFROFhONjBPaXpReENpSlhwV2hEbU9KN3Vs?=
 =?utf-8?B?Q2U2bU5QUDFxbUFDTUszdmhUYS9Gck05cUJ1Y1g2KzJlQ2lURERlVkVqblFi?=
 =?utf-8?B?RE50ZWhKWlpEbkVmVVRreTNMaTFiU2lmNlV3dlNQTlJCUFJWK2lKMkU5TlBB?=
 =?utf-8?B?S3JhNFZPd1FvakNRb2F4QVRNS1M3SUV4L0FnclpmUm0yWjlvblpFditvRnRt?=
 =?utf-8?B?bG8xNFJvOFRJVndZTjRxNXNvYk9SMnhTV1EwMHpubjlXV2kxNWRMbURGRjl4?=
 =?utf-8?B?RUJjOVlPSXdvUWxiY09CSUg1WXNNTUNESmRVVW1HbmllMmQvVnY3TnJqMXR1?=
 =?utf-8?B?YnVjNlN5c25UL1lZMkRiWjNWazk1WVRqNmlycUlKUEZrNnNxZUZBanJ1SjNi?=
 =?utf-8?B?amcweG00VEQ5Qm9DeVBiejk4SmF5bWN5MXQ2R3ZMcjBQOUJRK0tMVHdsOFRM?=
 =?utf-8?B?K2pxTnNXRzFOem1EdEZ0aUY0ZGJUZks4TVZwU2xPVExCV1pESzRzdDBtRjFl?=
 =?utf-8?B?UjR0Q0JhZ1EvTDVVbGtXTE1nSENna0h2aFdUaWVrem00cHFwNjR5bWFxWXBN?=
 =?utf-8?B?TC9wNnVocTJVNXlXeHdoRGVIbXk1dE44TDdtQlU2UkVib2p6MWxuV0pPWWJ2?=
 =?utf-8?B?NzNBRmJZUk1YZngyZFdoN2xwNUwyYjJQdzB2TlV2anZsM20ydE9mUkhlM1J0?=
 =?utf-8?B?OXprS2hPK2krQ2dIVXdKb0Fyc2JETXB6c1dnUklJVzMybHhGYm1DaHJtamxu?=
 =?utf-8?B?UjVWSG1rS0R3L0ZnV2pabER2NlQ1d29ZTEw5RncveGcrcGZmM0pSNEJncVNK?=
 =?utf-8?B?clF5TTBNT1ZjRk5wbTlHN1VOWk05ZkFBR1hyMlN2NnA3TEdnVlE5YjdCcWw4?=
 =?utf-8?Q?9k5z2BMRWhFujmRv89if/pRMI?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OEh4Y1pEbmE2bmdOUy9BVGxFdnhKTHNZeW9penIvSzlEWVJtYy85WHhNcHdk?=
 =?utf-8?B?cFJRVG5nQWF6NGd2c0xGYlFmL2s3M2NMSjVQeWhpNDlieDJVOGxwUnRUc1VN?=
 =?utf-8?B?a2piQlZkVHMwMDlERnF6VXFySHNmRXUxSHlVZGJZbzlpYkJHUVFoYldMMndt?=
 =?utf-8?B?OW5hYkRxa1hwVVNuSVRpSFJzRE9WOEppbHZlVXVUUGFXRUhKc0xZQkNsdHlE?=
 =?utf-8?B?QzJKS1lJRURlVDM0QmZjb00vMHBPUXhaWG9mdnhaNWwrZFdKUHJ3MFhXR3A3?=
 =?utf-8?B?TXlVSXM4VnNFUEFKMUpwOGZnYW1ROEhOViswYVZxdkYzbmZGTGRDdnoyZDVp?=
 =?utf-8?B?aE0wcVNWWEhLdU9CenZpOGNLWWptT3AvRkd5alNQeFcrZGdDSkY2a2xRZmpJ?=
 =?utf-8?B?czh3aEdjSVp0RkptbXhNcjFnWUJDNXdqVk9QeGRQV2hZc2p5cmVEVDhvTTNy?=
 =?utf-8?B?MVFqemV6bWlObzBTdnY0cUlmaWdHRitHV0dHWTFRSityN3lqY2FXMDBuQXlu?=
 =?utf-8?B?QUkzVHZzWmN0eEJWRFdpajVTMTQ3R3A1T29mVm5RTVZ3WXBtWXdXcHZ6TEcr?=
 =?utf-8?B?WFJLQ3pQdGowd2JwRDRZSUVGUWVWelFOajBLL0FOVnVGWUtDYVhtcXk0dUZw?=
 =?utf-8?B?WTYvSzExVlFidVo1M3BvM0xvK0RsYmNuRkNIQ2twd2N3SW9ja2h6WEswQ0wy?=
 =?utf-8?B?WElZRUVlcm1nNklua1hMVDdlUjYzTDlVcEpPWlZoUlg2V1ZoZVZla1RZMjZZ?=
 =?utf-8?B?OUREaFBsTytsbFpYV3pROWZkbUVNMGtMcnZTUXkwVS80WEUyY0dJSDZLYjNH?=
 =?utf-8?B?WjBHMk9QTlpoMFhqOWNZODRIUzEvT0p0NkhNQUp1UTJxaWRhaU4ybXVNOXBC?=
 =?utf-8?B?bWgrNmRpVk04N2FOMFBDZzBaSEpxTzViMXJrbFpjNEg1Y3FwV21GWnVLZW5J?=
 =?utf-8?B?TWRsTDdzQnJFaU5QdXRJMko4M3ArVDBGalFzcU40TGtJVW5GZFF2RkN3QjE3?=
 =?utf-8?B?UnV2Nkw1bkQ3VlRQbWVmUExtUkRjT0dRQU5XaERIOW9DNVJGMVR5dlRJMk1z?=
 =?utf-8?B?WmNqSkJRUnc5MWJoTHpuaW9VelpFZ3ByY1laTnlIMmZrZDgwQmRZSEFxaEpm?=
 =?utf-8?B?OWM4TDh3NFZ5RmZabHJhREpEczhYbnVTL2YreDY2d3MvWUpmT3JsUkdWV0tv?=
 =?utf-8?B?WG1MU2h5ZEVscitGekJoMnp1Mm42aHJ6ZjJpWWFIdERvYmtGNGFxczBlcTF6?=
 =?utf-8?B?TlhZMzcxM0xpN25wRUZSNnFOMmFYTkxZaGpTZnJIeFJuY3ViTzU1RGhjQ2dZ?=
 =?utf-8?B?UlFiNWR1ck8vMGIyODB2Zi9PM2RKUnk3MkJrd0UrZEdZQnA4TzZQZFgyNkxK?=
 =?utf-8?B?NGJBOSswMlo0SmtUbHdUK0I1V0M0REVNT0I5djdqeGNVR2p5aDFUTy8yL2FY?=
 =?utf-8?B?S3djZStmM0FrRncxa3FUVm9VMTdTT2FVaHIyVzJYT1M0cktNcUd6dmh3TlNB?=
 =?utf-8?B?aWtEdSt1RU8ya1Bmb1hlV1J1N3hoLytEeWVJRE45QmF5VFBIMlZQODZ2eHJs?=
 =?utf-8?B?UmQwczlWbDhPdktIdHBIZUhTblN2Q2crMGpjL21KV2FTUFFRNFloN0pYcnFO?=
 =?utf-8?B?VGZzQzF4d1hhdmpCMTVSZjhhUDdTZC9ieHpvNHNnS0N4UzQ5QVlWMU1uamtr?=
 =?utf-8?B?V0Nsa1NlckxSNlc5WUJKOWJ1OHh4OWVrOTN4WjZDWFY0TjBxc01HWjA1eExY?=
 =?utf-8?B?VG5HN2pGMEpWRkp5QXdyT2hWdk4rTjNyOE5ocUpocnN1WHM4cm4xSklTeU9u?=
 =?utf-8?B?UHRMWkwreWswZldIamkrUVkwdmVSM0NqTE1lWm9yTWova2NlZDZSM0pGdnBv?=
 =?utf-8?B?MjB6M25NM1lKVkxscjZMRjJLakVwMi9HWEEzVFNZZFlDODZadVpSUGYrOVVn?=
 =?utf-8?B?bFovWkFaaktCOU9VRmRwcDVEZWtxcWVRTFdScHJLV0h5UG9Pd3lLejV6N042?=
 =?utf-8?B?aTRDOWdxSTg5bTgxZDNMWGJaQ3B5NUVDM2lseVo3Mm9wOStzRlphQ2xZWkgz?=
 =?utf-8?B?QmtmVFZ2bXk2VW0zSUJQWFVGV0ZYWUptZ2FRR3RKdzBUV2I5Wk96ZVUxRkEz?=
 =?utf-8?B?dEFJR0VVcGtjTWh3NHMwc3kyczh0dExaSTgveGlGbW9rNjF4cXpoUWQ5NFIx?=
 =?utf-8?B?L0UyLysrRGUvWTdydm9HUXIvcFpqQ0gxRUp5T25Mc2kxVjhrK1Q2WG5KblV4?=
 =?utf-8?B?VUJBL3Z4M05wbkNaQ0dHM2lnNlZNNXQ0QndBeFZ5MTZGYndDblFnTzN0MmJn?=
 =?utf-8?B?QURMbDNrdE5KNlZ1UXJyWGJ6bzN1YlM0Sno2cldFNXhPWmdtSm81Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f296f2c3-c2c9-41dc-7467-08de72947b9f
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 04:31:58.9780 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YXNZAMS3RZL37hkWfxOturG8dpWtSGtEB20eeslyH6A6ILTyBM++dFeY+Z4S6kUwKb6A+i47uMngYzmCjCPd2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8059
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

Applied the changes @Tvrtko Ursulin <tursulin@ursulin.net>

Regards
Sunil Khatri

On 20-02-2026 06:49 pm, Khatri, Sunil wrote:
>
> On 20-02-2026 04:54 pm, Tvrtko Ursulin wrote:
>>
>> On 20/02/2026 08:28, Sunil Khatri wrote:
>>> memdup_user could return invalid memory allocation if
>>> there is an integer overflow. Using memdup_array_user
>>> make sure we validate the size requirements upfront
>>> and return with an error.
>>
>> FYI:
>>
>> https://lore.kernel.org/amd-gfx/20251205134035.91551-1-tvrtko.ursulin@igalia.com/ 
>>
> Are you awaiting for anything to merge the changes Tvrtko or they are 
> merged in drm upstream already? Since issue is reported now so we need 
> to fix this.
>
>>
>> And later:
>>
>> https://lore.kernel.org/amd-gfx/20260202125149.2067-7-christian.koenig@amd.com/. 
>>
> Yeah i am aware of these Christian changes and we decided we will fix 
> the issues first and reorganize the code later as needed along with 
> Christian changes. So we are going to push the changes
>
> on the existing code base first.
>
> regards
> Sunil khatri
>
>>
>> Regards,
>>
>> Tvrtko
>>
>>>
>>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>>> ---
>>>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 32 
>>> +++++++++----------
>>>   1 file changed, 16 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> index 212056d4ddf0..a6eb703b62c4 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> @@ -480,8 +480,8 @@ int amdgpu_userq_signal_ioctl(struct drm_device 
>>> *dev, void *data,
>>>           return -ENOTSUPP;
>>>         num_syncobj_handles = args->num_syncobj_handles;
>>> -    syncobj_handles = 
>>> memdup_user(u64_to_user_ptr(args->syncobj_handles),
>>> -                      size_mul(sizeof(u32), num_syncobj_handles));
>>> +    syncobj_handles = 
>>> memdup_array_user(u64_to_user_ptr(args->syncobj_handles),
>>> +                        num_syncobj_handles, sizeof(u32));
>>>       if (IS_ERR(syncobj_handles))
>>>           return PTR_ERR(syncobj_handles);
>>>   @@ -501,8 +501,8 @@ int amdgpu_userq_signal_ioctl(struct 
>>> drm_device *dev, void *data,
>>>       }
>>>         num_read_bo_handles = args->num_bo_read_handles;
>>> -    bo_handles_read = 
>>> memdup_user(u64_to_user_ptr(args->bo_read_handles),
>>> -                      sizeof(u32) * num_read_bo_handles);
>>> +    bo_handles_read = 
>>> memdup_array_user(u64_to_user_ptr(args->bo_read_handles),
>>> +                        num_read_bo_handles, sizeof(u32));
>>>       if (IS_ERR(bo_handles_read)) {
>>>           r = PTR_ERR(bo_handles_read);
>>>           goto free_syncobj;
>>> @@ -524,8 +524,8 @@ int amdgpu_userq_signal_ioctl(struct drm_device 
>>> *dev, void *data,
>>>       }
>>>         num_write_bo_handles = args->num_bo_write_handles;
>>> -    bo_handles_write = 
>>> memdup_user(u64_to_user_ptr(args->bo_write_handles),
>>> -                       sizeof(u32) * num_write_bo_handles);
>>> +    bo_handles_write = 
>>> memdup_array_user(u64_to_user_ptr(args->bo_write_handles),
>>> +                         num_write_bo_handles, sizeof(u32));
>>>       if (IS_ERR(bo_handles_write)) {
>>>           r = PTR_ERR(bo_handles_write);
>>>           goto put_gobj_read;
>>> @@ -666,37 +666,37 @@ int amdgpu_userq_wait_ioctl(struct drm_device 
>>> *dev, void *data,
>>>           return -ENOTSUPP;
>>>         num_read_bo_handles = wait_info->num_bo_read_handles;
>>> -    bo_handles_read = 
>>> memdup_user(u64_to_user_ptr(wait_info->bo_read_handles),
>>> -                      size_mul(sizeof(u32), num_read_bo_handles));
>>> +    bo_handles_read = 
>>> memdup_array_user(u64_to_user_ptr(wait_info->bo_read_handles),
>>> +                        num_read_bo_handles, sizeof(u32));
>>>       if (IS_ERR(bo_handles_read))
>>>           return PTR_ERR(bo_handles_read);
>>>         num_write_bo_handles = wait_info->num_bo_write_handles;
>>> -    bo_handles_write = 
>>> memdup_user(u64_to_user_ptr(wait_info->bo_write_handles),
>>> -                       size_mul(sizeof(u32), num_write_bo_handles));
>>> +    bo_handles_write = 
>>> memdup_array_user(u64_to_user_ptr(wait_info->bo_write_handles),
>>> +                         num_write_bo_handles, sizeof(u32));
>>>       if (IS_ERR(bo_handles_write)) {
>>>           r = PTR_ERR(bo_handles_write);
>>>           goto free_bo_handles_read;
>>>       }
>>>         num_syncobj = wait_info->num_syncobj_handles;
>>> -    syncobj_handles = 
>>> memdup_user(u64_to_user_ptr(wait_info->syncobj_handles),
>>> -                      size_mul(sizeof(u32), num_syncobj));
>>> +    syncobj_handles = 
>>> memdup_array_user(u64_to_user_ptr(wait_info->syncobj_handles),
>>> +                        num_syncobj, sizeof(u32));
>>>       if (IS_ERR(syncobj_handles)) {
>>>           r = PTR_ERR(syncobj_handles);
>>>           goto free_bo_handles_write;
>>>       }
>>>         num_points = wait_info->num_syncobj_timeline_handles;
>>> -    timeline_handles = 
>>> memdup_user(u64_to_user_ptr(wait_info->syncobj_timeline_handles),
>>> -                       sizeof(u32) * num_points);
>>> +    timeline_handles = 
>>> memdup_array_user(u64_to_user_ptr(wait_info->syncobj_timeline_handles),
>>> +                         num_points, sizeof(u32));
>>>       if (IS_ERR(timeline_handles)) {
>>>           r = PTR_ERR(timeline_handles);
>>>           goto free_syncobj_handles;
>>>       }
>>>   -    timeline_points = 
>>> memdup_user(u64_to_user_ptr(wait_info->syncobj_timeline_points),
>>> -                      sizeof(u32) * num_points);
>>> +    timeline_points = 
>>> memdup_array_user(u64_to_user_ptr(wait_info->syncobj_timeline_points),
>>> +                        num_points, sizeof(u32));
>>>       if (IS_ERR(timeline_points)) {
>>>           r = PTR_ERR(timeline_points);
>>>           goto free_timeline_handles;
>>
