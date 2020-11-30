Return-Path: <SRS0=Nkia=FE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191BEC64E7B
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Nov 2020 14:41:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D53420719
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Nov 2020 14:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YunHHm/r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D53420719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18EA66E4EA;
	Mon, 30 Nov 2020 14:41:26 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3A4F6E4EA
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Nov 2020 14:41:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fqwDzYuwMaYnOGmexXEFWb5RppeNtfScKSZ77yEryX+G9z1IbmRHXf57ImVdgOnoBU9B8V3Em86P+3wGl5fMykxupFfMGugdCNaKFlYRgv7jd7/yEf68wNxLgLWEAuoJ363C4zg5joKK/KcdNam/gMqBovYZaphvUIhnJk2sQPEdY/3rnZJKXRe2gt2psHCyW5yaN0jM6o0+DCBB6p4cXeMuKx5vxvgahKxyvY6qMarr3e6LsIqrVq6H37McJxgX/4+I/QDKve40uu7J1wOA/u5bnuPH+2bXF9b7K8ma8u71E0673jX2/TjnCzCAheMgDDZX46TQFd6P6BmHHY/2Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5P1oBswVOyYISODGbluV2oa5Jg+qZ1dXq5nmEtq+P9A=;
 b=CKzy0Kovw8aenD6ZlRU/S4LCsr+cWzKFtUnSdO/q+SQ0e887E5tts3JZSQ9ufw0EF4eJuO9oJUGqo6GGx6WJsqfzznl9d9TcluBCm9fBYX0a7N66OgV6nJeVmSgg0rNkGnDaN7p448wQgMkA7G72OI+Es+xEG1MPqtubL54PErbEKeDziUT1LzPp/SBO3fmWBx3KqneiNy2U1pRKOwCXwgWH91U+fnNE2V3BTQQa+UYULM+J8TZ6/1f5f+RX+BD7s1ubLOoieL7/drWS+VkXjAvLlI6M05UScyS4oFSERI1RAPUD5WJcbqx/VYd2rZAWDgFsIU52q9BQM40oR0piPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5P1oBswVOyYISODGbluV2oa5Jg+qZ1dXq5nmEtq+P9A=;
 b=YunHHm/rY1qZ4s3BvOBhU0iqbcvmrSJsTeDTVkj05BuKS75UAyKxfw43qJeo0xItdymCu5M8PC+AzYZ2d9mnC2pr8GYvvyJOJs56qq5zwRo1WQSyWVvixFGhYuq51RttH6N3VHsix4cpmQw+9gy8wIkdEpOCTiwVFgZWZ5ztcOQ=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3788.namprd12.prod.outlook.com (2603:10b6:5:1c5::13)
 by DM6PR12MB4313.namprd12.prod.outlook.com (2603:10b6:5:21e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.22; Mon, 30 Nov
 2020 14:41:22 +0000
Received: from DM6PR12MB3788.namprd12.prod.outlook.com
 ([fe80::4b1:55e2:de86:887c]) by DM6PR12MB3788.namprd12.prod.outlook.com
 ([fe80::4b1:55e2:de86:887c%6]) with mapi id 15.20.3611.031; Mon, 30 Nov 2020
 14:41:22 +0000
Date: Mon, 30 Nov 2020 09:41:12 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: Wayne Lin <Wayne.Lin@amd.com>
Subject: Re: [PATCH] drm/amdgpu: fix compiler warnings
Message-ID: <20201130144112.esn5jkoheq5jcipk@outlook.office365.com>
References: <20201130075421.3118-1-Wayne.Lin@amd.com>
In-Reply-To: <20201130075421.3118-1-Wayne.Lin@amd.com>
X-Originating-IP: [2607:fea8:56e0:6d60:fa59:ed82:d489:7fd1]
X-ClientProxiedBy: CH2PR10CA0022.namprd10.prod.outlook.com
 (2603:10b6:610:4c::32) To DM6PR12MB3788.namprd12.prod.outlook.com
 (2603:10b6:5:1c5::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from outlook.office365.com (2607:fea8:56e0:6d60:fa59:ed82:d489:7fd1)
 by CH2PR10CA0022.namprd10.prod.outlook.com (2603:10b6:610:4c::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend
 Transport; Mon, 30 Nov 2020 14:41:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 51e2bb5d-57c7-41cc-a2a8-08d8953e019e
X-MS-TrafficTypeDiagnostic: DM6PR12MB4313:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB431393FC7C38C8CF7E43D38698F50@DM6PR12MB4313.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zW1WUBlRpQ2RukSSk/pvdUZI+OpzkTJhDDFu6myo3cQ1BOUl8CmdJg44r97Xt7K5qmijwRzICeNk0zsPj5PAp6k2b42wHnQeojF+dJzipwGXind3LK6G/WGg1UmZFVkRFd78hGTmcC/8Cm/cKIWQO5CdYifYvZaU445SYM6MAcS47tFyti2jVfZoUIU0RfSw+fbd6BLb7Sr5M0O/3mMwoa+qLtkORPkJveMtTiNSX3tv0hB7BzHP7pWg2QwSPAGVTyMv1kVZ3pEHS7V+98Jya1BNIPuTeAyds6UA87O/DK/oPx9uDQJprWkP17d0toaZw0e7MLp9BCzvn52xL2olWyIcp9rCE58Ick5Do7WhqUlTCW/dIna/97/P/LFPpFkPXPv9d7zSc2yZ0EbUKgOOU0qGjmf60nVMEVL2VuWQzGl1VgGw0qVz2bagOPCgYYEjvIbuUmWa7sucQX48MWSTQQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3788.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(376002)(39860400002)(396003)(366004)(6666004)(21480400003)(16526019)(83380400001)(186003)(478600001)(316002)(966005)(9686003)(55016002)(7696005)(52116002)(4326008)(44144004)(8676002)(6506007)(66946007)(8936002)(66476007)(66556008)(6862004)(5660300002)(6636002)(1076003)(86362001)(2906002)(2700100001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?oIu2xqxfItj8ZQTyORdjGvreGBnABWvL32KjesLsGzRwwLiEOqyZx/WDGfgu?=
 =?us-ascii?Q?oUJ01WKB90Vg7MOgLMg3sndOSym6RX5zpW1BgyDilX5QbVqamNwpo0bMcDEL?=
 =?us-ascii?Q?NRCsteMuTTTwJLkNOTDlqiGv0cA98rm+CoIL645ZJ0iVj70ZwRrpQ+QezkIp?=
 =?us-ascii?Q?WRQ79jwlPcjPgtJl0r3URuPSDhFzQjm2FyH7mq8Ch1PW1TT3INDEBda6naLc?=
 =?us-ascii?Q?AKaZtOw860f6SFKToD7zXTLau3volW0F5WAUL7GauMQ29ebEOdl1ZcWmWDaL?=
 =?us-ascii?Q?LIXFSuJUumfllWkIZR2+qWtj7Gc+JFjtnhq7LDk5GtRtfSHtH09uYh3Q55H0?=
 =?us-ascii?Q?7m05wkyM1GARSPd9IZgO32ERHWcxJ9O1SpdCvJBcu5YLrpuWP/7sXxoDQtdW?=
 =?us-ascii?Q?uwFCWtlMJiersh8PBot5NRKcpZkelnLyk3gGgo+UpBcMrW2ALVua0V9zEt9V?=
 =?us-ascii?Q?WX5/U9ZYkBBWeHkMZT8siiPcFqa8eTefApmdzO1cK30CcTvXRBlatiDHlUjM?=
 =?us-ascii?Q?ncPAySZuHVU1Rj5n2aLbm8RCxFuYv4WpxwteL1M2JXhBs6wc8UToeRfMbIXu?=
 =?us-ascii?Q?Vx4d08MNMLYflooPJ3wwxZbXbXCF/GFSyUZ8TDSZGf2cd8eW3p5Bg0fziUIg?=
 =?us-ascii?Q?saoTtdPAWudh5fe7/DiXuGYF1p0hB3RAKfRSKsTYkQY8Xqt/gwMU3Bt1kv8i?=
 =?us-ascii?Q?zLW5FZ7YcoXq02PYuqcUSYs/+WZ6jWx4GwJ4gqShgVfyV/rrvqs9eYVd3A40?=
 =?us-ascii?Q?J6iMBAV9DlX/tRXnywVLn9zFODfiA6nkqmHNR1aKsMNgXjOm0aHcEu0bv3hY?=
 =?us-ascii?Q?3uZPPmb/w146SO2lOZxgQfrYpFQuw4z0ZZ8O0F2GJ5E9HuB7boi8toOzO0W4?=
 =?us-ascii?Q?HcgRakSYU1k5nr0Yk+P+TKZWOPx6eL1bvlK+vPAdJ8ceHkoycvuvoR7K7Jw8?=
 =?us-ascii?Q?li2bRN/HguhQhnNydky0HPnuze9yC+g6Bfa2RkG3hbR2Je2mRMjB3dRQaFi+?=
 =?us-ascii?Q?4OHOlHgBe9+69SrjCjKFZvgutBTcrC63ZDFrs17/lqD8N2jpbTGCN9tkS0o3?=
 =?us-ascii?Q?rzpAhdWI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51e2bb5d-57c7-41cc-a2a8-08d8953e019e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3788.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2020 14:41:22.2778 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IlrpniWkMqgM/XAiQBBM+4S45ZJmkMPt7lugKvcADV4B9VrrZONuOZhQc2W0rKRoeEW0vKugqlJs1coPBAK8dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4313
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
Cc: harry.wentland@amd.com, Nicholas.Kazlauskas@amd.com,
 amd-gfx@lists.freedesktop.org
Content-Type: multipart/mixed; boundary="===============0768819959=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0768819959==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vqxotcggvhjl5klz"
Content-Disposition: inline

--vqxotcggvhjl5klz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

On 11/30, Wayne Lin wrote:
> Fixes below compiler warnings:
>=20
> All warnings (new ones prefixed by >>):
>=20
> >> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:5374:5:
> warning: no previous prototype for function
> 'amdgpu_dm_crtc_atomic_set_property' [-Wmissing-prototypes]
>    int amdgpu_dm_crtc_atomic_set_property(struct drm_crtc *crtc,
>        ^
>    drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:5374:1:
> note: declare 'static' if the function is not intended to be used
> outside of this translation unit
>    int amdgpu_dm_crtc_atomic_set_property(struct drm_crtc *crtc,
>    ^
>    static
> >> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:5398:5:
> warning: no previous prototype for function
> 'amdgpu_dm_crtc_atomic_get_property' [-Wmissing-prototypes]
>    int amdgpu_dm_crtc_atomic_get_property(struct drm_crtc *crtc,
>        ^
>    drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:5398:1:
> note: declare 'static' if the function is not intended to be used
> outside of this translation unit
>    int amdgpu_dm_crtc_atomic_get_property(struct drm_crtc *crtc,
>    ^
>    static
>    2 warnings generated.
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
> ---
>  amdgpu_dm/amdgpu_dm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/amdgpu_dm/amdgpu_dm.c b/amdgpu_dm/amdgpu_dm.c
> index 1818d9392..f42046d04 100644
> --- a/amdgpu_dm/amdgpu_dm.c
> +++ b/amdgpu_dm/amdgpu_dm.c
> @@ -4975,7 +4975,7 @@ dm_crtc_duplicate_state(struct drm_crtc *crtc)
>  }
> =20
>  #ifdef CONFIG_DEBUG_FS
> -int amdgpu_dm_crtc_atomic_set_property(struct drm_crtc *crtc,
> +static int amdgpu_dm_crtc_atomic_set_property(struct drm_crtc *crtc,
>  					    struct drm_crtc_state *crtc_state,
>  					    struct drm_property *property,
>  					    uint64_t val)
> @@ -4999,7 +4999,7 @@ int amdgpu_dm_crtc_atomic_set_property(struct drm_c=
rtc *crtc,
>  	return 0;
>  }
> =20
> -int amdgpu_dm_crtc_atomic_get_property(struct drm_crtc *crtc,
> +static int amdgpu_dm_crtc_atomic_get_property(struct drm_crtc *crtc,
>  					    const struct drm_crtc_state *state,
>  					    struct drm_property *property,
>  					    uint64_t *val)
> --=20
> 2.17.1
>=20

--=20
Rodrigo Siqueira
https://siqueira.tech

--vqxotcggvhjl5klz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAl/FBIQACgkQWJzP/com
vP+nwBAAiq9RTavK8MP+HUCW5JzQw8KeEW11ciMXq+JKhQEtM1BrpJydOXzyuhh/
g45oO5e9erVSA/c0srvQqf99/d0OcETK1SYfWSuzEHMfr+t0lJnPQt2mXjrIc3G6
skxkUwajFcvaP9RfmKUwpm0OcjWCp6RrpvIoeaG7hGNetWQwghB7+NuHwJcCCXgE
GiM7Dg0Ey/8D/AVjRzG5eS9F+fHko1e/ZHorgkwTXrnOm5zNNu+GbnpU83T9ZuEz
efzCX9IYMeaXqLJssSUzg3CXqyUH5rx8ekDaNa2D0SMUOoa8WHeFL8EdMWJTVXiZ
fuKcPIst0bUgwZ5G+cBkn0NVsUHSlcrQCKrSmbchuyWZg9NM/IE2KKFYjfuO+Qoj
aOwtPc3wwhNBN6pBwVX93ZOXFoJhUqR6WoVOVDTD8Hv+HFx8uig0wfiun0hF8rcD
Z/6cNdvTCrouvjningGeIeoYgYmOAY2ZTgFv1dAMgXnI1rTqsIR23r48a4pVBNod
/Kf1fVVGLc7CnJvhw0iwGzHXLpya8pKusJ2kAXeQnaOYz2nWqvga0rWiDdgrSbGu
arjXE8KIEuwFVVqLqWoZXNVvnA/VQNNiJsVEcbW6jOGNrYs1IFxyz5dy5OdsPkW+
y10u0icoHmJsXSndxHqqarnh54l47JG+RjW/GrwcKKvnoVIzZgY=
=2U69
-----END PGP SIGNATURE-----

--vqxotcggvhjl5klz--

--===============0768819959==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0768819959==--
