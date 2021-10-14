Return-Path: <SRS0=AM0C=PC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 128E0C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Oct 2021 01:41:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B670260527
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Oct 2021 01:41:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B670260527
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F07A26E123;
	Thu, 14 Oct 2021 01:41:23 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D62306E123
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Oct 2021 01:41:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZfMtcre5XCJ7wmMYCpUPMCCJrVbB0vG3NelN7KaoH7CaCSICD6l555HQH4eju+DVJMgb3nDqC4E+Y9tQTaaBaC4pIYxNaTgwb+2fDXELWi73SBFTFRmXmsS8NmUsjizLEIPg/Ij6czlahJ+dHMnGVwHkiEbe8XM40/BXWOHMWbjV3+5HHGui7FNLk+3LmtVrvEbXv08fEMN1yB21ZHUyacMhryy+ohxpW0t111zzuwxpwQQn+ydzbyTK9RwYC3m1qJkC6iqu4QdFq0rOiW0HDTktf4xi7O2W4D6h6GlNs/DToRzV17NRJc4UEUyR5ITnNNWZxDjtNJZpWiZU0dA/Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QAyJ97tRG/oLyBp1hQjGrOfpQ45rgzrH8y4OkCc+Rq0=;
 b=LwvTzpzaM/dgKqTIkG+D+vojJHNfkl4dIFmiOpVSskybecH5tvBQUmDh7Rk/aEsN29QCIg9IFx0egEkDjJSBtDlWx1wvtDEFnp2aT2tb/8ty6mccgnM1Z2GW/XCyzwHYIpUA4zglQrM1uBf7hHetMYNbFsCTTXUhkkoOczv0Hq/mzcABC/1uGVViYGVQHEfDljwoerzUnZAH6pQbuU7Aey+Mf+ND9ksi51hsmlGhWAlexJgoIZ0Yx37FhwKnf0rt9tcM1+MCSiiLlI2rIwglVsgo0g/T4wpUNyQ/OrsrNtguOXIhbBORx+D8v56IW30/b9lWZYdfCHUC1RUb2miB5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QAyJ97tRG/oLyBp1hQjGrOfpQ45rgzrH8y4OkCc+Rq0=;
 b=rddyF271XLpKJ2dHr7XXIL/1N0Q4N1Zrk3E9V8xhdls3DkkuzwVcNOl8geDQ1vLKDeiwC99v9Mm5gi8GRIAR9pR/ecB9rFFPt2f+K8ys8cxiJpgRwWNbKYAzmkLKJNLzX7OQK3SDMJtL9LI+ZNpiPDtu0impUJ+l7DXKqaKrskY=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.20; Thu, 14 Oct 2021 01:41:20 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::35c8:7b2f:1090:d3a5]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::35c8:7b2f:1090:d3a5%6]) with mapi id 15.20.4608.016; Thu, 14 Oct 2021
 01:41:20 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 3/3] drm/amdgpu/psp: add some missing cases to
 psp_check_pmfw_centralized_cstate_management
Thread-Topic: [PATCH 3/3] drm/amdgpu/psp: add some missing cases to
 psp_check_pmfw_centralized_cstate_management
Thread-Index: AQHXv4FViEmDEdllyU6AVj/lfKxpQqvRuAmg
Date: Thu, 14 Oct 2021 01:41:20 +0000
Message-ID: <DM6PR12MB261955EC5754D6E20C98DF9BE4B89@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20211012155307.1059170-1-alexander.deucher@amd.com>
 <20211012155307.1059170-3-alexander.deucher@amd.com>
In-Reply-To: <20211012155307.1059170-3-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-10-14T01:41:17Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=7c862f09-54f1-481d-9b81-a7fc99796c5e;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 478b3a07-889a-4c0f-c50d-08d98eb3b904
x-ms-traffictypediagnostic: DM6PR12MB4075:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4075A90C178AD308987112C6E4B89@DM6PR12MB4075.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vG7wx4XrXNyoOtBx6V8QZNztIvA9vNlo3RzByVNvd6MDIekD1yCcFyO6Uyz18XgXqh7DtEXaaiknbwpsVZb7jHhuKDcAXQmymn2cOPnfGzxu01HWJXzuJDCAh8agGRpTFVgvUBUPrwmm0weKkcOyqyRxDNsrqzzOJQ0oti2gbkE3A8zDudSRrQuE8UlndaC5a37Rmjrtcnwb05SGoR9oOpxkvUsPUpp2JNhMiVofhnbKiPpY0DZyHxfCd/xUmLgTccz5edZeGNeB2m9U8SY30z+wftHcoToCTcm8BnGMkX4BItVb4jSdd8YaCxd4cmAkWOL40y74sfkkYhNOZ+J28f3x3Y9j20mHMQkt7RYBcBSmFgwjbVMdZQqztycgr4FTLq50Coz+m8IVySTMhPq31EacqOBzlW9MEnXiKAm0JsrwQ+lpzj/qW+4Fu5zAxb0EFQk6nD+R89zhqBqYcVrmhzBFjGRMKAlDYNdRVtpJcgkJiMrSP8CVaj5XsZJkLWYrMYk11DnBwABN5Jc3u5SQ5DPm202mxbKwihjSxJCklfUKt12oy4VX68s+6gpWROlZsM1fGoopPU/hLczpR8Hp8/ezYFAS9SHGkLexX6gKAY88tiFy9ekfL5kIjI0zr4DetfJPPjSvh5CRxQ6YXc1vW4+6hpUAYoLrX5jDni2g/X+nkHwlTZZQ1Gj9Kfnl4xTqSsBTOFUt+bXJKl9/wMcvRw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(122000001)(186003)(8936002)(8676002)(316002)(71200400001)(86362001)(26005)(33656002)(53546011)(83380400001)(6506007)(7696005)(76116006)(5660300002)(9686003)(508600001)(66946007)(110136005)(38070700005)(66556008)(52536014)(64756008)(4326008)(55016002)(66476007)(38100700002)(66446008)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uv/5ctadETl1VWHRgTjW4ZZ7RIo88FBOL6GcnxZmQOhlbhshT1edttuGi1Ko?=
 =?us-ascii?Q?qTm3BA08VdhufiWKqOKSsifnXaaZHOSg1m4jc3lLxlMVjlNu73d4/dm5NYsZ?=
 =?us-ascii?Q?cFhKTMp6BUtIWDKWxl3whFPifPTjw/jy+teem23aOewpP2A5BgdxcyJxzyUv?=
 =?us-ascii?Q?5VhQLu8VBJB8SGtMVjJcklKNZPpkJeAuQCofozL1isHuVrbPULGjMNbq/P7W?=
 =?us-ascii?Q?FX8EaCOmV71bqGQaX2lPvTAsmg0lzltg+sDLu591AdXEs0nbHl2a7lmlItYA?=
 =?us-ascii?Q?I/pKtM3LztO2p2cMlHjUa1qpfBH+6Tu3mVvHvo4O/qCXjrXNMCUP6cC0mKRv?=
 =?us-ascii?Q?vjrXisaf8xYUqwzQ1pkn/o5Ulem7tRg35eJDfGlk7nlSt1FV96t6GOETMyN8?=
 =?us-ascii?Q?P60XLz8VMo5yNFmLxBM2cJ2OjYLy7mBfdl2Xz/C/72wEuEXG4SqLB5YiNt3x?=
 =?us-ascii?Q?bBBnPUSbKE65aSPtMwPCM8oCTefqV6Pbn4IxH5k1u/cDiZDtYZxvwjVFcCGO?=
 =?us-ascii?Q?u2rhAD27MmAFHOU70fXMQNSroZraSFVII6kgwjMmA9RGTuo9pdXLNu7JppHH?=
 =?us-ascii?Q?ZiEqD3/97ne1qxhjEAPE4lSPYf9m3XiIefR3YYb5EwMMpvB6B7AFODfPhdKc?=
 =?us-ascii?Q?Mz3nhxwF3vBdiK4RJYpgyHglBkuySgPKofQYEopP9Yw2YJo9kWbh0HhKv8HD?=
 =?us-ascii?Q?LruaYgJGK+vwqh7vLJuxO5C186tGzqvwI0KifylrGhJNRGCdP0jeHxgYw8lZ?=
 =?us-ascii?Q?8DVXRcPzor4ceTubsdwcYrk3qTlZqh35n61XFmw4rJo8Si/H9zCzw4B+VPfb?=
 =?us-ascii?Q?EOYfuncNUIpO/yKUmBWxNg6+igIDpUEoRi31YAYERRcI1zPzhubqUUQ9zpFx?=
 =?us-ascii?Q?ZZQVPcOy/2jJ77/laV7lqGtxjr0NkkXLrp5DrIvMUnYHIKhl0ByVgnp7WLOC?=
 =?us-ascii?Q?Lan5VunD8bvuYgSedEWTm/hrSt5LWpVY38wlQ+HPxXLRgmOeBCKngzjhe1/x?=
 =?us-ascii?Q?/djuWgv1fDIdb2UOdXHiOzBt6OKfEs4j9PwsBCfHBypk9w9sldQ6GC5yrX4T?=
 =?us-ascii?Q?NIRNOaAxY4LKVKdN7hjo6BayDZo4tlH/TXYBelF9oyfK/IWK/vn2HUS9+CvW?=
 =?us-ascii?Q?cBqbWYAIjhekwnwISBMvMjQcaNPk1St/rTMvh4chfvGlTgoahWHrrxbO6XXc?=
 =?us-ascii?Q?NAnV62+kGOb9ajGik0caNDXYH6mCWQuHBwjYWCznEHZEYwk2/+mVrMpDOm/0?=
 =?us-ascii?Q?TjfEdKEFlev2bNaqildTw9iAU/lq7fBr8xFWE9VKXKUiPN5UMAVIwtasM9tk?=
 =?us-ascii?Q?vCgwG4IBCY7PCNUBS53nSfUC?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 478b3a07-889a-4c0f-c50d-08d98eb3b904
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2021 01:41:20.2554 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qL41QOgeq8fmlaayB9RSo66vU6HbQxSvGB1xKJiXvAyZJeltEqv163Kjpudl/X8V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4075
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

[AMD Official Use Only]

I assume IP_VERSION(11, 0, 0) and IP_VERSION(11, 0, 5) are for Navi10 and N=
avi14 respectively.=20
Then according to the code comment that " pmfw_centralized_cstate_managemen=
t support is available for Navi12 and onwards only", I think they should be=
 handled by "default" branch. That means this patch seems unnecessary.

Patch1 and 2 are reviewed-by: Evan Quan <evan.quan@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Tuesday, October 12, 2021 11:53 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH 3/3] drm/amdgpu/psp: add some missing cases to
> psp_check_pmfw_centralized_cstate_management
>=20
> Missed a few asics.
>=20
> Fixes: 82d05736c47b19 ("drm/amdgpu/amdgpu_psp: convert to IP version
> checking")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index 6b39e6c02dd8..51620f2fc43a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -77,7 +77,9 @@ static void
> psp_check_pmfw_centralized_cstate_management(struct psp_context
> *psp
>  	}
>=20
>  	switch (adev->ip_versions[MP0_HWIP][0]) {
> +	case IP_VERSION(11, 0, 0):
>  	case IP_VERSION(11, 0, 4):
> +	case IP_VERSION(11, 0, 5):
>  	case IP_VERSION(11, 0, 7):
>  	case IP_VERSION(11, 0, 9):
>  	case IP_VERSION(11, 0, 11):
> --
> 2.31.1
