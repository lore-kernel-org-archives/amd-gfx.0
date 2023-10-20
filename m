Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7BABCDB474
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Oct 2023 10:31:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 198CD10E59E;
	Fri, 20 Oct 2023 10:31:02 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D43DA10E596
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Oct 2023 10:31:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AYi2MYliicmGtIDoFvW4QB7F7gDP/GZyoM2Xzm1hQ9kM/K+fIpPSjbhgoOWAhT1tr0r3toHRyb5px1oVOelk2p8zrqzLctd6N9+GxuJccDjJx0BkV8aXaoDAVC9k8xJJyJlI0K+LoaIP0Da2yYHb2u9vT7sPV29s8hWqQjoxxUvIFynIbf/iQPCtcEMk09ADB1Sou80wajieV/lyEtXbOSNtaGGUZOzp1ZKm5FJFCPG9pmp1UZUNsmhMaLDA7hKwXuKSDjDnuYJq1NxXdfhIuhWpRnYOyrvpQaLxUL3qtRnIf7jpIJTwk9YTRWeuVVsdHfhY6U5AcvQKKueQ0BDuyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2yFx6p9uSjh8MDqbkZW7+fVkV8Ay/cuouf5UzU6FrYc=;
 b=UuuZwOB0h+dkaPHeup4oquwBHrR2O8GBL46S2e/jOUnMAAxcXYIzQrSqQx6ue2Tt6vsZbVi7ndrRu0D0rBarkdtaOP50AKEtq/UnN3ms3+by+AMgUzzejnd0O1JlZ8Dj6bDWbwQGdyYcu6PTwuG5XOqML3ux62Jc6gx0oQdOCoprbAO4OhjH1sf0MoctkZy61pZZ0N0NkXTO1Nmca45hr6DjtIihI2uNYM+88/7lYahS4oY/X8XBY8baatwX/Xtb0oV292etfyak1CPEThg2oLEveQr+r4OqjJVKHQ1cglVB+m88RTq6q/kTeBTN+I/gN1ltPvdoAs1BbiWzvEpTEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2yFx6p9uSjh8MDqbkZW7+fVkV8Ay/cuouf5UzU6FrYc=;
 b=dutZFEkSrF4uZ+c4BSa8NKn7QT3RxEJeZapzoXB7d7QJ0WHTtU0RxgxKD936ERCukTtTkVLH/3sckHZwZkRExBTbBDVOnodpo5w5DU9xHc9fSASEw3PFAlZMOlHH50GmwnLbJHjvH2VC6BmutgGmpDQHQ6edfcNGe+akpxnSQrA=
Received: from PH7PR12MB7988.namprd12.prod.outlook.com (2603:10b6:510:26a::22)
 by SN7PR12MB7936.namprd12.prod.outlook.com (2603:10b6:806:347::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Fri, 20 Oct
 2023 10:30:58 +0000
Received: from PH7PR12MB7988.namprd12.prod.outlook.com
 ([fe80::d59b:2efd:b690:583f]) by PH7PR12MB7988.namprd12.prod.outlook.com
 ([fe80::d59b:2efd:b690:583f%7]) with mapi id 15.20.6907.021; Fri, 20 Oct 2023
 10:30:58 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: enable RAS poison mode for APU
Thread-Topic: [PATCH] drm/amdgpu: enable RAS poison mode for APU
Thread-Index: AQHaAz/0k0OwP7h45UiaVYLA2/pzd7BSemHA
Date: Fri, 20 Oct 2023 10:30:58 +0000
Message-ID: <PH7PR12MB79884F2D8622679EE14ED85C9ADBA@PH7PR12MB7988.namprd12.prod.outlook.com>
References: <20231020102628.29419-1-tao.zhou1@amd.com>
In-Reply-To: <20231020102628.29419-1-tao.zhou1@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=14363956-6765-4961-8ba2-a1bba10f74a0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-20T10:30:26Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB7988:EE_|SN7PR12MB7936:EE_
x-ms-office365-filtering-correlation-id: 75a793cb-3edb-4217-3215-08dbd157a618
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZKEkIjcKhptrhzraZn1nqOOOcjWE4WEuJ/UiEabb115pUc3WLQrgU/it9BPWE0+LPheKZkGx1S26E5ZQqEhX96fN396RfiByp3NKMNVjKxKStYnbmwGPAM6xbeqo66WdAcUZUzQUlP8GiLeqq+YkKS3bVMsVkjS9ptRf+PCg/HFDvi2/4ORGDjzVX04e1NUjQ7+5sNCjh9R9bsLzJsOEJr54Dhn3M5pgmoiZWeWLHmUrAyvgnOdOC4t8Eu2FStd7KYI3qkUjIXNvDNRL7OndgYMY6HP+XNCpzDTZ7SdLDKH73vYsI0eDGG+7NhnXR5XymxLUAOt6nOjlGJ3gdmrghTHiqN5JQ9kNEPmY9Crw29KFTnL/gxwc7411cwaCs+Qs7eJTE9p0KVdQnITcOqfSg/PfStS4GrmCJjY/38hw52jio/0qAGQq+D0mxi44Ax8pCEfDPmfEyvy6LNjwjkDd8nZreCCqgCT9q16EwvnjYRpNzvAficRjZip81oM/T0ISOn6aB16SJzmfhJQuOMzgVaSv30SH96iTVZa/H/04IMHGe0UyUrS2va1SO1RXxgYhONrH5Wrz3wVSb0nqGCF7NSEXdFVhEeNe8G9e9JWVnqNjPGgLFQvJDN2NH8VBOJsd
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7988.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(136003)(396003)(376002)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(55016003)(38070700009)(2906002)(7696005)(86362001)(38100700002)(52536014)(41300700001)(5660300002)(83380400001)(122000001)(6506007)(9686003)(4326008)(53546011)(26005)(8676002)(8936002)(478600001)(33656002)(66476007)(110136005)(76116006)(316002)(64756008)(66446008)(66556008)(71200400001)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FO1fRY+8NClVSzxnqmZ7VsoVGSxRJ/ODcupcFASkIF61Be3rAt6c5BgDlMq5?=
 =?us-ascii?Q?KbtNhd10iN6qbIQjtjJicgYufC5fF41VDAltZS20PLwcPDk+ktyabz4CvdWv?=
 =?us-ascii?Q?4RaSfke6WDUFilHzEpe2NYlZhoDqy8jQmkK97Z0Dhpfyd8HKI/n6oMcyKXUF?=
 =?us-ascii?Q?ZSgw1w/tK4mcLJrBjGymGKXvfZjwmbnUOY+iZegkB+WXVfB3Q7MR+c3Yo6E0?=
 =?us-ascii?Q?mB7ArotkKPil4z1S18jXB7N0HrOLr7thafhV3Ol6VzF+cg1b1RwsradXhjL5?=
 =?us-ascii?Q?pR8URlnJmAeH4V18RVmK3CHu7+8gkSnwdUUraqGPgGdRGlAo78tRqvYpimra?=
 =?us-ascii?Q?SkyUWldUm3H1PQZ0cL2ofv2aOx8A2ioBRfaVA2be1ru4wQhJj9RDO/ZXOXCW?=
 =?us-ascii?Q?GJG0pUj2ZhFqqlEpibQ3+7sAgsx1I3dKM4cLlXCqvpf8j3q+myOkocl+xWhs?=
 =?us-ascii?Q?qBuCayqWOJUNeN1hebbKZu+jm/Bm4mC9HG5M7jww5LeocY3DA8IG9DP1w6fa?=
 =?us-ascii?Q?TDaGvqtYqmmCi8pu32gYxG3ras19VfMSbfBqoAgSude1aW+XqNBeBVvxPntL?=
 =?us-ascii?Q?h+VkFLzql4dlp1RrDSLJV9Gnsh0bFdfeJyFI7ptGeuurtRQInDC+KxNLFwc2?=
 =?us-ascii?Q?ehtHTjO120qc2TulecRSy3K00bERNq6kIpSEEZZyoIh7Xyd5/xejXCalrhL8?=
 =?us-ascii?Q?hvA1RdsbDEELhuNQgog4H5AIxlNBXKqWUQ7rXsNiSH/o8DOkirQYCFGopC1c?=
 =?us-ascii?Q?Dq3R9E/t770/QuVHcHvcvS/jr0KHF4C55v9bUKblRoglWbtE3QGOv8U/CIlV?=
 =?us-ascii?Q?CPgevOOM5srWPNhIC+NlcRrPPbeDZD4PIChjDVcty4Jnvagc3mpAbYwMgaFi?=
 =?us-ascii?Q?CWqcr6v6eBrPz/hGXlsRV9xZM8U+4I5uj45+eNOToC1umtFj/QbUUGYjiMPj?=
 =?us-ascii?Q?zIGL6WRmZqHul77M2YPH8cvGyzSyFtlJecHwHUKr/42c3+tZ4LBsUJyr+zNp?=
 =?us-ascii?Q?yQM1xsNZnBAiK1rwI5lajOVSPf4FImZOhPFDdRehYKkxNhejK9G4PRyqZhAV?=
 =?us-ascii?Q?o1G1QnL2ZJwa3MjSGLo0+CUkk85V6CekYIh/eZZ6+zI+KCD4+Pufz3TvmhqD?=
 =?us-ascii?Q?S2k9kJskv+rLfF/TJe5D9kkS2BinuDlGqrGvLURYTsZZAk88H9gywICYcoJa?=
 =?us-ascii?Q?uaRkeTI6PqAbXOYlIqxGSQZJPE1eVKhXKkfHWRl0mBU0lPCsOAu8vHZ8eSCm?=
 =?us-ascii?Q?y9qThOND5qyWMAv8Gq85G5sh0+MbBmvcdwZGtsmucyPsEn01F9hHHDj23LT3?=
 =?us-ascii?Q?QkigbzjSIWHrxtEA2L9qNi4GBpvbxe74FqpAQYoTk5W1pwzrXqC1nqa+WDnp?=
 =?us-ascii?Q?CE/A9t6Z/KzSiboFMX/kdTt/hTJ6bSyVbcPD+NC47SZQdIcZwOunsiYYZy0G?=
 =?us-ascii?Q?fXye+rZufOKcKDZFsMRksePiKpSU/TmC44RxESnxLY/BYZR0vg6czvA/9BCj?=
 =?us-ascii?Q?0MDyOZa3U1K47SKTDWOpiAO9q8ZzNlKAd9lhP4gy+iVaG8xHPsRmK+I4hCzB?=
 =?us-ascii?Q?pufMDFyibCfp0yJGY2o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7988.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75a793cb-3edb-4217-3215-08dbd157a618
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2023 10:30:58.1257 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kQM+3INzVF7fng7poiknZqT6f6358ZdeA5C6Bis0KDuoYq8MkDRhoB02d7a+Gl9TNnuw6h5Fyk+gUtYoNy+72g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7936
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Stanley.Yang <Stanley.Yang@amd.com>

Regards,
Stanley
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tao
> Zhou
> Sent: Friday, October 20, 2023 6:26 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
> Subject: [PATCH] drm/amdgpu: enable RAS poison mode for APU
>
> Enable it by default on APU platform.
>
> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 95c181cd1fea..a41cab0a2f9c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2710,7 +2710,8 @@ static void
> amdgpu_ras_query_poison_mode(struct amdgpu_device *adev)
>               return;
>
>       /* Init poison supported flag, the default value is false */
> -     if (adev->gmc.xgmi.connected_to_cpu) {
> +     if (adev->gmc.xgmi.connected_to_cpu ||
> +         adev->gmc.is_app_apu) {
>               /* enabled by default when GPU is connected to CPU */
>               con->poison_supported =3D true;
>       } else if (adev->df.funcs &&
> --
> 2.35.1

