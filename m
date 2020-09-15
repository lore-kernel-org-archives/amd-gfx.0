Return-Path: <SRS0=7kRa=CY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36291C433E2
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2020 22:24:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98CC220809
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2020 22:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="uN8BaSkq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98CC220809
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE0B16E24B;
	Tue, 15 Sep 2020 22:24:03 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5042F6E24B
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2020 22:24:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EAsl5X/A9C7jClhOVWmzNK/2LvrZ5JCC0VEN3v0wdmOx4HwWyiem0hmVAJcIGW6GZwMm4AyLtJvq1HXem/80kym+gddXXpVEsoXO2wAgUMGCoRJ6af+7hOtXerztu32qXbz/0csTgJc7MgMXVZqv94QB2V6UQISD/R0bLKMa3/S4RSeNDBKc5fmOi+UtdpOZnQY1m46384qP6SoA2YJgLNOkd1NP74Cyxq/BNKekFrd7B5biD8Q+XTGOhuH/QVQv+5QdNb4UMaznrVdeXoJJGJAU9PPUveR9+BUBn0iKEeBrLMMCGUZfuTEUgPIjzQYmz7kx+81GOeZZsnHKIMx3Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vKyIpKbpvR0ZNbvgj8wcbG13RxuC5AkeqUvjw8ihDZs=;
 b=CiLf/Z5RCJZzDSB346BwSo9UwYWSRLZ3tZ5QO3k5xowx1YwdMLLsMfESofN6k1ZmeT8I078xHFmnT0TJKmixoeYDveGV/tkAmTq58QvD98m+IqP/7yJvcmwSfVTYd8bv2D4FkDh1PBWNvyzxvEuvBvv/Tp0xFakPKNmTdpcv0tlWuqAh595DLrFSgNNY3GNZc91YpSlK/RkmlaXiLM5Ylt3IWJFQvLJf2WuXaDINUWf4Pl911kLrYWOqMym5pMU6O+zrCZKfIuCO/czYMxkaudGB6EfBn3VCP/FtlVCgsoyC03vyztJ+uutSujs3fM2cVEkIWgfNzOKvWo7HAngwPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vKyIpKbpvR0ZNbvgj8wcbG13RxuC5AkeqUvjw8ihDZs=;
 b=uN8BaSkqpbjd0f6S1RIqCYwLKZtqierVNpi00k/x3CYx35aAOKT8eSjTpo20SFSd8/rxJy2QEHwb7umNmBTdwo34mzT+fEWgZaQafXamHRmQSOAl71D98plfqLna28CfteMtYm0M3vpVxe86ti+ry6JIidxvbu6XU5gOepmKwcY=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4124.namprd12.prod.outlook.com (2603:10b6:5:221::20)
 by DM5PR12MB1834.namprd12.prod.outlook.com (2603:10b6:3:10a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Tue, 15 Sep
 2020 22:24:00 +0000
Received: from DM6PR12MB4124.namprd12.prod.outlook.com
 ([fe80::25a1:ace4:4ca8:167e]) by DM6PR12MB4124.namprd12.prod.outlook.com
 ([fe80::25a1:ace4:4ca8:167e%8]) with mapi id 15.20.3391.011; Tue, 15 Sep 2020
 22:24:00 +0000
Date: Tue, 15 Sep 2020 18:23:57 -0400
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Subject: Re: [PATCH] drm/amd/display: Don't log hdcp module warnings in dmesg
Message-ID: <20200915222357.4wbflsepvjxxtbo2@outlook.office365.com>
References: <20200915213852.3383231-1-Bhawanpreet.Lakha@amd.com>
In-Reply-To: <20200915213852.3383231-1-Bhawanpreet.Lakha@amd.com>
X-ClientProxiedBy: CH2PR10CA0014.namprd10.prod.outlook.com
 (2603:10b6:610:4c::24) To DM6PR12MB4124.namprd12.prod.outlook.com
 (2603:10b6:5:221::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from outlook.office365.com (2607:fea8:56e0:6d60::980e) by
 CH2PR10CA0014.namprd10.prod.outlook.com (2603:10b6:610:4c::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.19 via Frontend Transport; Tue, 15 Sep 2020 22:24:00 +0000
X-Originating-IP: [2607:fea8:56e0:6d60::980e]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7281a100-8fdd-45fb-87cb-08d859c60b72
X-MS-TrafficTypeDiagnostic: DM5PR12MB1834:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1834DB5910A0EEB9E7AB0FCE98200@DM5PR12MB1834.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 10xk9yCthfBASjwxD3pIjjE2FP03TblE/sS3vtwaQZODnVWjS7neI0lNqVL9ZsEwp72SBkKNu6o4X9l1FSW08u5wlWuYhxxxMnnhitpMsXiCT+xjLqCKA8wA6YddnnYIZZDqj2PbC6h5idhblHYeH0Tg3751q+iTfMFQ8T1jRvOW7n+zcmEMVOmjx9SfsWQKVoYqCvn9Sl95ssC1pSWVuGfD+bYyGX/f7VfUzKMYQQlfPl3vtYmMH+UME88Ejn8hzrARBwdLANocq1oCVLHqnQ+Q2H94WVhahJKVpea9/MmZ408v4znaN6iCL5K++hwN2E2YDuzrL/XoFXpCeJr/cft99mtGiLXYtIZrSuA+Hrmvb6T6LvjvM50AY0ghZvd4jhULZ6lDxG655HVdRlUeFd/5aU84TJ93nrQPI/1StfwJHPBlW7dSz4vA5osxoP2zNzoGSWRsDJLWOJ02RTEGtBlv7cMwzx/toRIESrrp3D9dC9k4g9eQNgjFoYfITrV5
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4124.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(396003)(376002)(136003)(366004)(2906002)(16526019)(1076003)(83380400001)(186003)(4326008)(21480400003)(6862004)(66946007)(66476007)(66556008)(478600001)(966005)(6636002)(86362001)(5660300002)(8676002)(55016002)(44144004)(6666004)(8936002)(52116002)(9686003)(7696005)(6506007)(316002)(2700100001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: GY9p9vIY0Kz8GCyknCPNp6eeMSoBiLquF/5lFWgkfa0ILvtW+XiS28hGImmChCBH8AvHyxwEYNlBg/ZtLnnP19y689PkKjmxu+LGnTbn4qRj1/FJP7Ye2kTg2TORVfyAO0+cp846Xog9DMbuu+fQYC4udO3tGUM9l9ZTPSoeEzlh07w2q3V2+3HvLCD7BSCfCCf/XManaqFtJQvk0fB6p3lGlChiBbqf6ntniaOl3QbbpT78k6aEOEaFXQEtVafp7N+yP//PG0pvRa1WOiCsnI3LFqu2XuEaGcC1jSW1gHlIyBz2ZImC3VUassPNuu9vEgerFJ+HSIsv9m0WzNuiiadW/FQKKBoSsLuAFGVF8KaSYJg5Kz798FJdOjWR3wVVlyY5RJIRoFBro0LPHZcPPpM7FcFJvGkp9BthFXB24SWoilYHBFryHCTUcEHP8aJSHHLgctECx/ijSAS7ABhLRiW5X88+Cvg703i2Cy4qM2n86TyQXJ7PKz3QxJRs3/Zfuu2D/CDz+A9uxoFkPfGBho2ao+iKIEX7ODQ9E8ewmN3rJ542VfBbcix0LHWwKd+QaB0FJn4Ukm4Bq2joKDPVVIg/1I9g/SmpiFdSvZ6gBQwqKqezVziaBMyeI9q4mAjaY3POgn3/0Nxfs5ECTs0VAXeB3M9PmA2c9zl0jfkMmXARICmRL2sOsDK/OCSVFoTp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7281a100-8fdd-45fb-87cb-08d859c60b72
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4124.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2020 22:24:00.5816 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Owzx7aLh1axa07HZzTlulemxydfx8G9dRwP/bYCMfmwSNN7ofdYPHDfRIh9gOsARxGn1ogw/R0qI9qpY+YQww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1834
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
Cc: alexander.deucher@amd.com, nicholas.kazlauskas@amd.com,
 amd-gfx@lists.freedesktop.org
Content-Type: multipart/mixed; boundary="===============0220588083=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0220588083==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x3cbiberbtoas52n"
Content-Disposition: inline

--x3cbiberbtoas52n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 09/15, Bhawanpreet Lakha wrote:
> [Why]
> DTM topology updates happens by default now. This results in DTM
> warnings when hdcp is not even being enabled. This spams the dmesg
> and doesn't effect normal display functionality so it is better to log it
> using DRM_DEBUG_KMS()
>=20
> [How]
> Change the DRM_WARN() to DRM_DEBUG_KMS()
>=20
> Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
> ---
>  drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.h b/driver=
s/gpu/drm/amd/display/modules/hdcp/hdcp_log.h
> index d3192b9d0c3d..47f8ee2832ff 100644
> --- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.h
> +++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.h
> @@ -27,7 +27,7 @@
>  #define MOD_HDCP_LOG_H_
> =20
>  #ifdef CONFIG_DRM_AMD_DC_HDCP
> -#define HDCP_LOG_ERR(hdcp, ...) DRM_WARN(__VA_ARGS__)
> +#define HDCP_LOG_ERR(hdcp, ...) DRM_DEBUG_KMS(__VA_ARGS__)
>  #define HDCP_LOG_VER(hdcp, ...) DRM_DEBUG_KMS(__VA_ARGS__)
>  #define HDCP_LOG_FSM(hdcp, ...) DRM_DEBUG_KMS(__VA_ARGS__)
>  #define HDCP_LOG_TOP(hdcp, ...) pr_debug("[HDCP_TOP]:"__VA_ARGS__)

Hi Bhawanpreet,

Thanks for this patch,
I noticed that some users in the Freedesktop reported issues related to
HDCP due to this WARN message; I think this change will help with that.

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

> --=20
> 2.25.1
>=20

--=20
Rodrigo Siqueira
https://siqueira.tech

--x3cbiberbtoas52n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAl9hPvkACgkQWJzP/com
vP/V9RAArOdPS8J0nQrL4RK0gpgOmxfWMA3YczdldicGZfk6ejXmldb2IAMhvy0P
74zNZ3wcaMwcLUGFRQjuwuWzPmGyWESQNWfeUuUfGUC0NnYbrds60nDvFkbwvSwI
ueozZUGs65UgW23fwPtzVZk3/YKkdyd22jRvK9dLyWcJb5cF5ssUNdE+4XHU+w4k
GmX5XbKQNRmCztQsxoCk+UhTRRos9dTyRMtIJCyizwipH/5CC7ZnCYS4Lq5ey3qF
ahKOs6ZAD8H6kLsAaaCsrr6pqOTGuCapCJXWeyBhOESRJhIydtPXNDTc6DKMIk9r
F7o82Hlueqvy4tKLFy33zz8achnwiTXzWrtnU3uYWVkYaqNVgBI4VU/RDWOCoOn9
AqNtwgtXUwSfl96Xdt/9bCCnchwWHZCFBWGibQ/1LzvOZkUVsH9HVDgLMojWeeS/
6toATf2SEkOAe5vB0fbByDOXgbMMfo6GWMFnrt+SwBjmjkKf71c1UcF2NLXt0W8k
QkWYnYJEdFo4g8NqPKuZ3lhwCwrWKRpc9rc02hAmp72G9Gs0StdjYYK2CixH9tJ9
rn0maX1woh4q0kkPzo2wZO8QDgUiOvg77fdHGvXA6zS06eoKhMlmXBwnJB9Ya3DT
/QdERAL355yGvFxvgCQPDXfCHENMUfROkBcfXl8Tosgp1B7wJvY=
=5Cus
-----END PGP SIGNATURE-----

--x3cbiberbtoas52n--

--===============0220588083==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0220588083==--
