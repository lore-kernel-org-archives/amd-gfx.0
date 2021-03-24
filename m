Return-Path: <SRS0=J6fF=IW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B036C433C1
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Mar 2021 04:12:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41F5C619E1
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Mar 2021 04:12:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41F5C619E1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02DF16E971;
	Wed, 24 Mar 2021 04:12:17 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770083.outbound.protection.outlook.com [40.107.77.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5618A6E971
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Mar 2021 04:12:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WKET8/Iemmab6cH37yKAGHN/TZLjzFKMao1reUCxya0H7nt51jhGZdcjjXhlcRjJIox/QUSb8Upf5kftZNhs4mnmtHfP0xFJgGNFAmcCK1rBwUmgrZEHbceQBL5OWcytaF8M7MsOsa/EizUf49v2eEjIE3L19djiZoURqJ3AT9TwQeFh5GqDGhP/WEaKxDBNN+bBFXXsfrHAOAQxwoo48sGTS3vHFfoYl3YvaSZfdVf1hphDUEwpXpneE5/RiQYEx2iYER8sIYzPBC2gchJfxDxRWgtIbAUeS7pslDvxXkrkEtC6aobXoiq57vaN0fsSOq0SVSru+b+TCQrihamZNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5j+iUvaC+QjqIhXgJJYhoI9qEE4OerVAHkqwKhhBZRc=;
 b=ZQqFB6I1rRis4y15R2IXYZoK5O0cuvm6RlLhp/3KzKSxabOXbaSneoHIjDx/x2juL8IfS2PEjlUJd9cIsD/4fzsi7udTN5js9OllbXA7MSHnDW+APG6mrcs8EDX9J4rvrZxIcND5JVXAqp1koom7g8j1DZdGM+q9BVZQ/Ys1DTQFirvpMb8dYZz6Wm9ULytrdPuCmWkMiwZzqUwTC9wC2yM+p4xOFO/Zrw463Y5BSLFLLPLQnf1kk3nzqEm4aRlhautm9O4SwcSneWPUmvg0VmoyMjGJzDT/FXNVQQJHA8GxSp5sZyN7qUyaeE8LcyjqQFEMl4S9hV2Ydydca+pMOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5j+iUvaC+QjqIhXgJJYhoI9qEE4OerVAHkqwKhhBZRc=;
 b=zL5HovItPKh03DrQrhfDLEOwa99t9a/gKB1ITIlkFKVbmTE3iUBehhyWy//Nd3QjVGbGB7/DrgG6sQGQgVG/GOhFF5ezw84SR2ZhVOKMVHp/YkxFeVeBZvtgHptCMTfffU3+zv5RIPxxCxNUAubfW3fbLf24B5K0zSFlJLnmXVE=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2601.namprd12.prod.outlook.com (2603:10b6:5:45::27) by
 DM5PR12MB2581.namprd12.prod.outlook.com (2603:10b6:4:b2::36) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.23; Wed, 24 Mar 2021 04:12:12 +0000
Received: from DM6PR12MB2601.namprd12.prod.outlook.com
 ([fe80::e887:3273:c806:d089]) by DM6PR12MB2601.namprd12.prod.outlook.com
 ([fe80::e887:3273:c806:d089%7]) with mapi id 15.20.3955.025; Wed, 24 Mar 2021
 04:12:12 +0000
Date: Wed, 24 Mar 2021 00:12:09 -0400
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: Anson Jacob <Anson.Jacob@amd.com>
Subject: Re: [PATCH] drm/amd/display: Removing unsued code from dmub_cmd.h
Message-ID: <20210324041209.bcmea72uriixhwnn@outlook.office365.com>
References: <20210323210134.432845-1-Anson.Jacob@amd.com>
In-Reply-To: <20210323210134.432845-1-Anson.Jacob@amd.com>
X-Originating-IP: [2607:fea8:56e0:6d60:b632:25eb:317f:fb05]
X-ClientProxiedBy: YT1PR01CA0038.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::7) To DM6PR12MB2601.namprd12.prod.outlook.com
 (2603:10b6:5:45::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from outlook.office365.com (2607:fea8:56e0:6d60:b632:25eb:317f:fb05)
 by YT1PR01CA0038.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.24 via Frontend
 Transport; Wed, 24 Mar 2021 04:12:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 36599c1e-0f85-4549-0d40-08d8ee7b0011
X-MS-TrafficTypeDiagnostic: DM5PR12MB2581:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB25812EBA332060C3DF017D8C98639@DM5PR12MB2581.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uvx/xsBuZeDoRrtCcjt1SLU6HoYJVazL8Nq9SdLOWn1h2ALZA8Xm7csatVmQOdiTAhFiJeUTzwC3B6EHQFFFVKYyYfJBv9AHMzYZxgvDEGzcX33J342CwHdXWsnGAC9lww/waEB06RPJcbmD1lv0YmpAhAr4fyDRlSDxO5M8tW3mO8jFXfsPXG0o/5A5TVy+N1yXniiw5lXkJOAQ2w1IDNCFi/MQMso8S65wGnD8N4IE1L/nz1xr935onBjMojXlbWzKlM/UjErrC9vUM5f+Rrm4zv9vdlzXiRILhmLFynHghi9nQwQbwGXxeJ9mLo4Qqb0tiPWSroC/eXQt1lWZ2aiOJWSnBixjjpa+9h4wgtL466l9i5uSjD6ZcxUw148N9rqJbumhis5spvmw5OH17Dz1G6aXNVj+MdULGhxnqqtgkQ/sqdn43W85uA9CMwf0bJW2kxUHwXdpAOYbxRX+OdmVNMC+sjsdJ8AzggN+vsIew95PWhjkf752EHzFRYKYtCVr0ZbYYmPcEj0OnuxO+Y+GPeXdWra9RJj0k1aWsD+65E7+k6BH+ZZhGZMni1nDQ9dSiNuw252Gu5dLjXwByqRE0Yi/DFCEdPAPmyc8VMtdWesZPmzt7i27Qza1+4gjSMlKsnPhGzXVFvpV/BAR+e8pyiTeYY23RFIIZ7mtkPwx2Q11UIgKaQ3IEpzxdmrMI+MVNna2dkRcx27at/jLhxnMgLAje7l6tkr6gAvnX4iaBfD15rHxLoAsGAhrv7d9zxUBSMk2sVIjDMes0RF0kA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2601.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(136003)(346002)(376002)(366004)(8936002)(1076003)(83380400001)(8676002)(55016002)(44144004)(7696005)(2906002)(5660300002)(52116002)(9686003)(6636002)(66556008)(6862004)(4326008)(6506007)(66946007)(66476007)(316002)(478600001)(16526019)(21480400003)(86362001)(966005)(38100700001)(186003)(2700100001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?kLXOhP16VJom4iI95x/XI3l7kIp6m6ZXebGvbRw6lSJYwFA2szemIJn7IngJ?=
 =?us-ascii?Q?8mGsEt9TWQuLQiFP7SBeV/MCVvy6pmxc09Bx5oUTr2zkEJflBQ7HyEaVzp6r?=
 =?us-ascii?Q?dDa00jEoexEZYDz2Fxx5Z34Qr3LKfkle0Ep1/4+9sYIXAVhU0PyJkVA9M4Fu?=
 =?us-ascii?Q?QCIIVnj838nF+t7zUHuyvG37s7GPFh+PNUOXKDpsBQso0Qe0VkqFQmRu/3Q6?=
 =?us-ascii?Q?NaHCS2bSmL8oURAjhOUJMN4aJOv0LLU1sFFjMsCm3aIoBXYtquAYzR7WC4J7?=
 =?us-ascii?Q?fPXD9xMi3p20mZZjD5zvZ/agMsPVAU1O33mDj3Os/qtLhC2iIwU5TM0WUY5e?=
 =?us-ascii?Q?thwEuqGvQDwxtwDavIz69DrGam/VwT1yuyKWG4LMcxS5pF9M5zwVVGXxMLA/?=
 =?us-ascii?Q?FKetoBFmqyXcko3NrxziofFe+qDOHEBP/H8KHxDadgChagPB6nfv+apkKZXp?=
 =?us-ascii?Q?LtifitT+1WqgxKRNnc1aRW9PIhjXuP5CixGrguYLCUUv0330qRxoGGgR2OVG?=
 =?us-ascii?Q?Z32992jV2JKfrq9vEOiuFdbRCGJ5qnQJoKg2+KTpA544XMMrgKh0aAzEZm7g?=
 =?us-ascii?Q?TJObQqSNAOQ1o3WrQFJAywTDRk9orKeuJ55LPFVZHXDOwutAMeVLn8F296EG?=
 =?us-ascii?Q?9wdPDw15Cp+BSUuZySQtrNOSBWAdF4KaCP+SPyxyHwiH3jkC2zW82LgGQuUo?=
 =?us-ascii?Q?/DrAnPjKE136louOf1fKEkRlpZDd3mY8nd5zgTHnecKAkKNDfwZ0rc6VWxev?=
 =?us-ascii?Q?MXEPNTmmgqwBFhhsmMw/KtWN7bNqieyJf+nit0yxGljBqCt5Nea0ivHIEHhm?=
 =?us-ascii?Q?Qf3lLFap/5CZi8HnvhinS5dqzeX6oMa0pQiDzysjSDTCRT5+dTIh+5Qkw5U4?=
 =?us-ascii?Q?4ma49h0Ye+8GDrXEIcZYiuj4ME95LeKDo7LBUzupQV7H/9K/StkJNvGvDOWn?=
 =?us-ascii?Q?qjSAC/9Eet8YrUD9MHJOqkYHalFPfG9/z7X2KuWjy7R1GqtbdHsQNzcTNhLV?=
 =?us-ascii?Q?DsDnIALLsQrQrsx5URrLdgDBH2uEtUAXw6vKK9HPMATj1JYDIPTIynqiIFFw?=
 =?us-ascii?Q?b7OWRd/BGRaNoH2cr9W4gxSHqE/h7geY5VwGmOOZBtS8nYH3jLDAkxU7ykuc?=
 =?us-ascii?Q?mgJuHv48hozDSVnLnXNmhr3AXwcmx6j6gpOllTM8BoGB4yl6n2bLIIGhSZFo?=
 =?us-ascii?Q?FQeddyuGNbAdMaJ3AG3uxudYCEsU8RcRHeuEzynuiaGtx2v0CiZZr4bAQ6UM?=
 =?us-ascii?Q?hbbggyvQ0fSfERbH4zh57uOgsvZ69qaRi3phnjJaF/BLEHbtIo4oxGhtXCSq?=
 =?us-ascii?Q?LFMiHxBiQH8OBEz7/PhQ4/16DPGAEICTL5QQwYqEVoO3nf9nsUpyJl+n3b1J?=
 =?us-ascii?Q?05h6o+AQnExfPIeY/lwKTJvCHNHd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36599c1e-0f85-4549-0d40-08d8ee7b0011
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2601.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2021 04:12:12.3700 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iVaOB6IBAFehmyln3ywob7/seIuDCKzv3wuNd9NNKqlOvWQ+bD/l0svrsr6xPmmiOOkNacpB+I5xFU9ipmRwlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2581
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
Cc: felipe.clark@amd.com, Harry.Wentland@amd.com, amd-gfx@lists.freedesktop.org,
 solomon.chiu@amd.com
Content-Type: multipart/mixed; boundary="===============1957837270=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1957837270==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2ujdd6fzdpv2t4cm"
Content-Disposition: inline

--2ujdd6fzdpv2t4cm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

On 03/23, Anson Jacob wrote:
> Removing code that is not used at the moment.
>=20
> Signed-off-by: Anson Jacob <Anson.Jacob@amd.com>
> ---
>  .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 37 -------------------
>  1 file changed, 37 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gp=
u/drm/amd/display/dmub/inc/dmub_cmd.h
> index 09c62485a1f1..2d23462f4980 100644
> --- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
> +++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
> @@ -202,12 +202,7 @@ struct dmub_feature_caps {
>  	 * Max PSR version supported by FW.
>  	 */
>  	uint8_t psr;
> -#ifndef TRIM_FAMS
> -	uint8_t fw_assisted_mclk_switch;
> -	uint8_t reserved[6];
> -#else
>  	uint8_t reserved[7];
> -#endif
>  };
> =20
>  #if defined(__cplusplus)
> @@ -532,10 +527,6 @@ enum dmub_cmd_type {
>  	 * Command type used for OUTBOX1 notification enable
>  	 */
>  	DMUB_CMD__OUTBOX1_ENABLE =3D 71,
> -#ifndef TRIM_FAMS
> -	DMUB_CMD__FW_ASSISTED_MCLK_SWITCH =3D 76,
> -#endif
> -
>  	/**
>  	 * Command type used for all VBIOS interface commands.
>  	 */
> @@ -1115,13 +1106,6 @@ enum dmub_cmd_psr_type {
>  	DMUB_CMD__PSR_FORCE_STATIC		=3D 5,
>  };
> =20
> -#ifndef TRIM_FAMS
> -enum dmub_cmd_fams_type {
> -	DMUB_CMD__FAMS_SETUP_FW_CTRL	=3D 0,
> -	DMUB_CMD__FAMS_DRR_UPDATE		=3D 1,
> -};
> -#endif
> -
>  /**
>   * PSR versions.
>   */
> @@ -1791,24 +1775,6 @@ struct dmub_rb_cmd_drr_update {
>  		struct dmub_optc_state dmub_optc_state_req;
>  };
> =20
> -#ifndef TRIM_FAMS
> -struct dmub_cmd_fw_assisted_mclk_switch_pipe_data {
> -	uint32_t pix_clk_100hz;
> -	uint32_t min_refresh_in_uhz;
> -	uint32_t max_ramp_step;
> -};
> -
> -struct dmub_cmd_fw_assisted_mclk_switch_config {
> -	uint32_t fams_enabled;
> -	struct dmub_cmd_fw_assisted_mclk_switch_pipe_data pipe_data[DMUB_MAX_ST=
REAMS];
> -};
> -
> -struct dmub_rb_cmd_fw_assisted_mclk_switch {
> -	struct dmub_cmd_header header;
> -	struct dmub_cmd_fw_assisted_mclk_switch_config config_data;
> -};
> -#endif
> -
>  /**
>   * Data passed from driver to FW in a DMUB_CMD__VBIOS_LVTMA_CONTROL comm=
and.
>   */
> @@ -1951,9 +1917,6 @@ union dmub_rb_cmd {
>  	 */
>  	struct dmub_rb_cmd_query_feature_caps query_feature_caps;
>  	struct dmub_rb_cmd_drr_update drr_update;
> -#ifndef TRIM_FAMS
> -	struct dmub_rb_cmd_fw_assisted_mclk_switch fw_assisted_mclk_switch;
> -#endif
>  	/**
>  	 * Definition of a DMUB_CMD__VBIOS_LVTMA_CONTROL command.
>  	 */
> --=20
> 2.25.1
>=20

--=20
Rodrigo Siqueira
https://siqueira.tech

--2ujdd6fzdpv2t4cm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAmBavBgACgkQWJzP/com
vP+rbBAAsPWFRnQcCUAZfrkaa4CepWKteOlr/U6MZhyJMHPkEWw27ru1ab6wyUsx
Ewz9srqTBCKmeicmoVw03SXrMDnJxG93dAx6Kx6SWcuJifHbBTLFLXf+vfOynVOS
1R+hTJOwUjb6ob032plwhH56cXiYeUlr7rDxUAcS7jkwffFuruHhcVTQRPAkCZig
bQJh8ERT4UgcBdAZzqE6rOEBJccAIq2JsALkN7WxRMLmZAIWaLR8NERFqLC94Vtf
aSA2nR52cDGWpS17ybMqqQT3rsIAe522DmEZJwh9QA2XE1XKbmGOgeeWzacLj54n
RuNjofjasETE0Y4/ZHIZrSmIR9twhvqpmbuBHpTI4wz/z2Nua3+HpUU9ct1MtM2U
4F/hoHehsDvIRuBYMittmwjTq5iyElEFA95W/ZCCuSRe2LaBbMeNgfdlxYkMa1Rp
+8+55S2hrRdsfK5FDWotg6BbBQpuvsWCsFoQi0cE0veL7m9X5/zfSvaFX/J2/g1T
SCh38OHZW9xsjeAUF90V0LRbuInbjIL0MB3vLolo8blnThcOZdwGEKfHDDJdZlEe
R52Zua23JIyvZvjDXwJt+3pjzqPiPeCEQNOZzE64hBBUvQaoZn0oiwXzSQi7ewA4
gsDV5JCi3eyvJQPCGiInKR1VzsQYUL+5yHX26vXokC24i3K51YY=
=+El/
-----END PGP SIGNATURE-----

--2ujdd6fzdpv2t4cm--

--===============1957837270==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1957837270==--
