Return-Path: <SRS0=AKuh=J7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C392AC433ED
	for <amd-gfx@archiver.kernel.org>; Tue,  4 May 2021 22:33:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 441D461027
	for <amd-gfx@archiver.kernel.org>; Tue,  4 May 2021 22:33:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 441D461027
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6E9789EAE;
	Tue,  4 May 2021 22:33:18 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFE6089EAE
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 May 2021 22:33:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I4MpPba+pGi/PDmKY9cqipEommJqyo6R0DAWrQM1lLSNenWvYmlKta+jmr6nQGBXrx4td1FtozH3GOFBJPjqGt7x+zHM/3O9NbsaCkUgo846RrGGgRFbkCpqb+LRv8CEyFLB/WUHoHpAagZzVYC0goHMAhMiyOmuVjKtydrlQu178/TwiOqdeGfiMbFc3rdzLKMgz5eEVw5fB3MLwvVw3kYh2SjcuuwFXVzaL1Qs7i861JRwPEHAEfkUDRcuw6OMPnLw82UekezYYJQCZxjtM2J6PBtR0GT5GH01a9WNgMBkXxJj1SJ7eIbO9gkCxV9QX/IvVAhkR1NK67vxQPu3WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9uBkTIxbHYmwxU9gicUsHMdPVo2mqbBIB057d4ALuKM=;
 b=hKhzMXpytQxGFUgTkcIZyLthnezW196/MUMVBEytifHQrsVWmoYemp1EOICq/cvkOK5VuoXIFPIrg+mIkPFY18G4A3mJyyL8zZ/wuEkMRIbxqRZBn8tCgIHDDvkmYZseASFbJhHXsfsHHEuRSocQukGSi/A7s4QSZ7bDBVyk/qQ6AzOiDQjKaGF7ulWO9E5LtfC7Ri0FXX9CUyYdtwHeRRcfYOOHX2g3kwML37tQMYBEquFlA/YxrjZgdaX2Xs/5739j2z6o92SOPqrY77xtMnBd+2szVw/Dp7JPq5Vt/8GQliUJz02mPgIsCjiG5FLqtKDDhbQFcqyiNizJXrGLSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9uBkTIxbHYmwxU9gicUsHMdPVo2mqbBIB057d4ALuKM=;
 b=AqtTHV+Fh4WfFvr+Kt5I1bbXwGBHi9aPImHmjO5ySAJyX+aG904dmfAQDtGjlhVHV5TBy2IMoKDSBqN3AbFbfp2hg9kfsEspBmCm8jLG9zGB8qltg93eG8x30/XXpF5bbTNl+mQTctTT0PK9oX5JnSZ+3XCPugP6peR84rkqIVg=
Received: from BYAPR12MB2693.namprd12.prod.outlook.com (2603:10b6:a03:6a::33)
 by BY5PR12MB4195.namprd12.prod.outlook.com (2603:10b6:a03:200::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.26; Tue, 4 May
 2021 22:33:12 +0000
Received: from BYAPR12MB2693.namprd12.prod.outlook.com
 ([fe80::c0c3:7247:a767:f5b6]) by BYAPR12MB2693.namprd12.prod.outlook.com
 ([fe80::c0c3:7247:a767:f5b6%3]) with mapi id 15.20.4087.044; Tue, 4 May 2021
 22:33:12 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "lenb@kernel.org" <lenb@kernel.org>
Subject: RE: [PATCH] platform/x86: Add missing LPS0 functions for AMD
Thread-Topic: [PATCH] platform/x86: Add missing LPS0 functions for AMD
Thread-Index: AQHXQTJ/ad2Os4BY6kmsWAOxw18t56rT56Pg
Date: Tue, 4 May 2021 22:33:12 +0000
Message-ID: <BYAPR12MB2693F7109BC8E7EF9F672A16E25A9@BYAPR12MB2693.namprd12.prod.outlook.com>
References: <20210504221140.593002-1-alexander.deucher@amd.com>
In-Reply-To: <20210504221140.593002-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-05-04T22:33:10Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=cb5b8c8e-3846-4865-b5bd-2118932172cf;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2600:1700:70:f700:49b7:e1c1:3774:6ab8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d3ff8cce-601e-45f5-cae3-08d90f4c9a0c
x-ms-traffictypediagnostic: BY5PR12MB4195:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB419505C42CD4ED3E51EFDE8EE25A9@BY5PR12MB4195.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:538;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p2U6V1iJwMMIME2zyGSXiS+CW/Nwu5GkGlV7EWx4yD5tuaZDnPYv6PDZw0sohqcKc1zXYJQ3oE9SI0ixk4LukkqeTMKW/y+gkv8sevZi7J5AxI8qNd3d/6oJ82wbju7f/haMyRztuu0b0PYq1vGcq4+EQRaQmAh5f4c2yBQ7tb4VEMw00WbdlCi1Mop+FS9qTb7dA07GwB7THC3E6vAzwxeaOZ6ZiXqPjUEamTVyR/d5L0FVnUuh3Ef+2J2kvIJxQzq6uXvHF6K7cU1FsWavXJqxfx08uoVD1P77Zn0w/jenyI2pw6w70ct3+97aH80gkKgFdsypuhdfR2unJoOra9hvob/hwTwiamQh6H+q5efk9AHUbsFZ56QGvxD85AKap3J9JPqHw/6teo9MwMdH2H6hse0VyA6ylTPw6m6QIPJny7qfX7bi7bSb3kBs5FDdIpBNpf8pFalhMcWDo/vuIXXHk1M4TD/DwMJJ+Z77iAqbWWmYk9cDZ/k9KuI7liZJl/bANW33eCp/8pVJ7pcePx46UlkhEy217VBtcHaWCS+pmgwYvSJUB0VVBpL6aEawVW0lVKcpUtd/IocaIB7Yl9uhB+XcwYuzYBpgWkjveZbD9h39wMoIRm/FYvIKXYjf/n5v+xa/DMm3K1Qj3dafhA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2693.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39850400004)(396003)(366004)(346002)(376002)(136003)(9686003)(83380400001)(55016002)(966005)(316002)(122000001)(478600001)(38100700002)(6506007)(4326008)(54906003)(110136005)(71200400001)(186003)(66946007)(76116006)(86362001)(5660300002)(64756008)(7696005)(2906002)(66446008)(8936002)(66556008)(8676002)(33656002)(52536014)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?icZi8may0qe7Nu5Nbn/m40PU/HgC6CBxaFQXZLuPHEV9AU5grj4rl8nMOiKo?=
 =?us-ascii?Q?JK4+cyS33dei2rxrpJUDmdPaj46Z1eFCsZUqE0c6aGBU67HHqZuVKmmaQPVK?=
 =?us-ascii?Q?VeMGqncNAcYEOF/MsvPZIH6CqgXxpk4NncdfHQWwUc0baWuqt6gdPTocQYye?=
 =?us-ascii?Q?KYOmCOzHJWZgGF+jVCkmDGgeqzqX4rnNUuf1aXB31ohZGDBexr/81NpW9o3g?=
 =?us-ascii?Q?LxG6rPVr95zNxF8NnAhsZEknBio7+e/F95QfUD5kGHigh2O8nJP0MFeU4SHf?=
 =?us-ascii?Q?05iSnccKajLnGvqcosxlIa+KCvREBfwCkNc8WKcX39nxI3zd/O83nnTfwx5n?=
 =?us-ascii?Q?AC2suVE8aZskOW2HTbnDUymEqR1RKzgLXxMDkq3MEXwm3F5Q6OBgjUvmEbqs?=
 =?us-ascii?Q?9f5JD3hknejPupghePMzg1Ssq8OabkgRijcje8dfq3AOXqqDIQkfpq64iR+l?=
 =?us-ascii?Q?r3Eg2nFhurBqzJOAAOdAhuT1nk1Ew1fAQWXCi63VU9mu4lQzAiyuvPuhhs4N?=
 =?us-ascii?Q?QNMkQ+UO2DEHbzC8TxV35gKIqlulqYLWuQdE5pfs/cpD2gO8alvZO7gff6MX?=
 =?us-ascii?Q?2IZg6dYQtMHhxzlYatQuJ1n+lta7S6HZAM2DkENLMvn6uXZ27dNGNAw3pBbh?=
 =?us-ascii?Q?Nc7KGnlKhxRmxRJ+NStnY3mVSSEKbK+yhchQr6EGza0fTrgbcbMUg8vJ7sjI?=
 =?us-ascii?Q?q4RQkISvnSuKczrYHjboLUzECKlYCwKorCrnjuOf0+BKwWugyI37zL1bPTIj?=
 =?us-ascii?Q?3NuH4SGlFaLxqPXiUSCmeJN5EjW6pmOawK2Ja1S1Q5IEPfxcTmg8d0247SCf?=
 =?us-ascii?Q?5knLxGWGVhV83fTPBPlE6PXM0AN8mQxNelsp1BVDwUfwWoyfIR/kSkL3bAMw?=
 =?us-ascii?Q?mHKsS4os412KYZWREFWFIkTRz424DSRYhgZ9gqRQKUUtHcXyF6Pq3ktnnRcT?=
 =?us-ascii?Q?Gdwf3YuOof87mlAUCYenDwr/mm4L06VEynGH8meBSeGSiJOeAR2eEVgffanz?=
 =?us-ascii?Q?H0JeTcZfNpiexzMlESSzvusJchV0Xh0PDN6WV5NZ7cDLfBbZ6yFTQPLELXYh?=
 =?us-ascii?Q?VHojpeSgOOaDQfz/R8y+D3hFxzU057vjVtdtuaekW8dUlxWI7xTfzDJ7Wp2/?=
 =?us-ascii?Q?U2pbBC9mcuSF2WJbuk2FD0MlHKowrPYKnDF7XYg6Gcn2d6ih5nsCBzDRq8Gk?=
 =?us-ascii?Q?pzRG62bTIxlQO2RLE9Zn2zkPw8lHLcBC7FIb7kvtZS1KUk3jsqjaiPjqzgTB?=
 =?us-ascii?Q?OvQ/bRov8cCznMB+JBakjeCJhUuQ5AA1k+IE230Hr17TmMLNYWJZB+n8vH5N?=
 =?us-ascii?Q?xsgbgQ1sLQ41OtcP36A3uyITq961kwqVAi6NwYtUgt8eVFe7xwz4D6dP//SV?=
 =?us-ascii?Q?HxA8J2AW4qYiOHVaaBDYcKv63irc?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2693.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3ff8cce-601e-45f5-cae3-08d90f4c9a0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2021 22:33:12.4147 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bJd+Bjb3taMSKeLi7sk6DtZsc9BNGkXnqTRjq5igO25HrhuHTIYObIvXonPXLf2LP5KnhgovnUfmganYqu4i9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4195
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
Cc: "hdegoede@redhat.com" <hdegoede@redhat.com>, "Liang,
 Prike" <Prike.Liang@amd.com>, "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
 Marcin Bachry <hegel666@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

> Subject: [PATCH] platform/x86: Add missing LPS0 functions for AMD

Rafael might be willing to fix it up on commit, but if you end up needing to re-spin
I think technically this subsystem prefix to match other stuff committed to this file
should be:

"ACPI: PM: s2idle:"

> 
> These are supposedly not required for AMD platforms,
> but at least some HP laptops seem to require it to
> properly turn off the keyboard backlight.
> 
> Based on a patch from Marcin Bachry <hegel666@gmail.com>.
> 
> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1230
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Marcin Bachry <hegel666@gmail.com>
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> ---
> 
> Dropping patch 2/2 for now.  This patch fixes several
> systems and doesn't appear to cause any issues.
> 
>  drivers/acpi/x86/s2idle.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
> index 2b69536cdccb..2d7ddb8a8cb6 100644
> --- a/drivers/acpi/x86/s2idle.c
> +++ b/drivers/acpi/x86/s2idle.c
> @@ -42,6 +42,8 @@ static const struct acpi_device_id lps0_device_ids[] = {
> 
>  /* AMD */
>  #define ACPI_LPS0_DSM_UUID_AMD      "e3f32452-febc-43ce-9039-
> 932122d37721"
> +#define ACPI_LPS0_ENTRY_AMD         2
> +#define ACPI_LPS0_EXIT_AMD          3
>  #define ACPI_LPS0_SCREEN_OFF_AMD    4
>  #define ACPI_LPS0_SCREEN_ON_AMD     5
> 
> @@ -408,6 +410,7 @@ int acpi_s2idle_prepare_late(void)
> 
>  	if (acpi_s2idle_vendor_amd()) {
>  		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF_AMD);
> +		acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY_AMD);
>  	} else {
>  		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF);
>  		acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY);
> @@ -422,6 +425,7 @@ void acpi_s2idle_restore_early(void)
>  		return;
> 
>  	if (acpi_s2idle_vendor_amd()) {
> +		acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT_AMD);
>  		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_ON_AMD);
>  	} else {
>  		acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT);
> --
> 2.30.2
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
