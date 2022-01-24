Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E819C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jan 2022 07:32:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C412410EBFF;
	Mon, 24 Jan 2022 07:32:26 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EC1510EA89
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jan 2022 07:32:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=REdsOZl6lq/PlBCyqzInAFiHwRipkzOIgsKf9r5RbhuAYYGfFSmqLvNyGtAxSCqdoyNgDXLxPjjiAHoZ27fdk+bcdbIdibh/rOfkuHzfPoqQr7nStsKRWAQjcBzA5J4gfYU0stonXVO22RrfqLxZ8eh7zPYy0Va48B7WHDF5ISPTAB4yHvIqbXTyR3HVchn7L8D/LRKFm8nr6GYwZ16H9Hq0/NONxLJtluiwc6Fu65R8uMpfjajWgbLlSzUwTHChc2cKSAVn8f5VkIhtbnMGTFmfJU7syQE4jGlsG445kTqyhNLVjAw9J3p1p6GXUUvJ8tp/Y+0165RSxAqXnA0yiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zri/n2qt69CfEFRppkxvxlREgKWiVFtfO6UASFN4m/Y=;
 b=P5rSGCY83bhj9Q2NvGKmdqhSiBKUj4DOd6I59f7FEcibeHibIcuClWqLYKSVlLd8UwCAETo2yl1EIDozADA6or77mzy6F5oGKwh06pZZ6LqvpLTzZMwk7ml7cq3sN86N7VVWUeTAgvSHqjs7BlPeySw2Wyd+rv3QSVaNx1DJ1zHLqDj53Yc5S5qeycmjbl+WsqTC+xXMI35AxwPBXyXdsNQBq6/OCz0ITj8cH5J7Ez0eyIWGrr65AyCr8pcQ0EQkOvys0HcQjpUnP+apcRbK2F6j+bRXcW0UO/ZtfwOyvwrTuUukbJVUa3mZ0LpnfjISw2mcK8QxgN6hd2wyjjPkHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zri/n2qt69CfEFRppkxvxlREgKWiVFtfO6UASFN4m/Y=;
 b=CPOr2tzn6hFaja/UeT6O2Px/VnuGeEciWTkHudzF1FrhdWUm0P5Q49T18k+4iEEGubOVUVoZEtFQYmSxSVt/DoIayrxCd1hefbX+bkx40zltZLvLp9d+veZIwwE1CO/tFC2OM6IMa6miWkTIC4SLKjoVJYyn7Ah/l/79PKqX9Go=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 DM5PR12MB1273.namprd12.prod.outlook.com (2603:10b6:3:76::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4909.14; Mon, 24 Jan 2022 07:32:23 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::f02e:2cba:7c63:e368]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::f02e:2cba:7c63:e368%4]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 07:32:23 +0000
Date: Mon, 24 Jan 2022 15:32:03 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Huang, Tim" <Tim.Huang@amd.com>
Subject: Re: [PATCH 2/3] drm/amdgpu: convert to UVD IP version checking
Message-ID: <Ye5V83QAwAaX2WdW@amd.com>
References: <20220124032042.1974371-1-xiaohu.huang@amd.com>
 <20220124032042.1974371-2-xiaohu.huang@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124032042.1974371-2-xiaohu.huang@amd.com>
X-ClientProxiedBy: HK2PR02CA0149.apcprd02.prod.outlook.com
 (2603:1096:202:16::33) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f36cb0d7-1874-4495-79ba-08d9df0ba95d
X-MS-TrafficTypeDiagnostic: DM5PR12MB1273:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB12730E24214B9C7D4F24E516EC5E9@DM5PR12MB1273.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:279;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b8F6HKySCRpkw3zNlf445HInvCqvrMJgH2fNOOpz/kjb7k+k4a6bYI3LA56iNrPCeCclmYHbmPRbu++t6fQMoO8LdFmBfr8pT6dIVgghpU+sk+t9xlX6CrN9a19sHQQO2WD5HPrsgfFvsmubDdwpDbL9+3uh4/yDHhmsOO5F+BzQE4TiLfR/w+vdENMFOJfHw66bTE0f424TWG9C4Eq+bQMU2cb6+zxOUt0r2tWMzA/3UpuaopOANtmRQ/AiGcDAe212wAeoMERj1rUzFXPo/bcfWPKPe9gcSVZ7ncxq24RldcMzRTqF5yIMbkWzIb1d1TIKdWpuLBdqqNYH86PR4q9RnDGaCPaZiJmYUj0XmELkWQqmfdZYAmpqH5eRIpUF2JJmEaanlVc1oS7Ijn2AafmAAFB/cOL4POPgnI14CQgyZh2C5kIF5K45JoaFffee5inwZhSVT88xbiyhtBC8UxaLcJ/kElx7oGZR9LG7rxHq71N+SNusxkhOuQn5wzT2KqIiwscON88uV5udjp3D5AZX98mDdPT3onz5QL9QHg32IOeVQCNk9MPY8XjLI/qkZYQw2ZzSSQs8tGp4guwx6R/2QXRdAvNlwD02BbgR3lgTPvB1OrTMyeE6EYO7n5EZm9rtlDhkQH9RV6M1ZVY2Kg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2504.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(36756003)(37006003)(6636002)(316002)(66476007)(2616005)(6512007)(8936002)(508600001)(8676002)(186003)(66946007)(66556008)(6486002)(86362001)(4326008)(83380400001)(6666004)(5660300002)(6862004)(38100700002)(2906002)(26005)(54906003)(6506007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+feFTWZBf2y0E9tT8Eyw2sRFOFUFOIsOxAB0tOrACj2scWK/e/uqfu2dzLcs?=
 =?us-ascii?Q?3NGyd28YPCAByCmZmWrboxTMAUml1wcWTfOitqwo+wJZvAPUqou88yXnElni?=
 =?us-ascii?Q?CxNmn2PpvCiEoVtXlAwoRuhhZLQzgoTfh/lXYaubB5lPAi7/ws0tICBKJW0N?=
 =?us-ascii?Q?L7fYsHxXf+mmsPqcIloyc9hZyf245CKZ1DIloZEDMWm6TelZDgfvcFeOAjmz?=
 =?us-ascii?Q?cereyIds9NG39mzZeYhwXXWXUPht24OT4CvJUF8f4foTK5chDdPBU3qLr95b?=
 =?us-ascii?Q?kXHkkGo1urW25NsaJHHklk0HjgiYzo34S1fFyWJ8Nv/PlVBqviZBTk7Pfosr?=
 =?us-ascii?Q?TW116ZQFR0BxZAfNrn03l6KFxYNxqoHV4h0bvIWyctgeVwH20lK0jxNL+wPy?=
 =?us-ascii?Q?xMRCO009Q1s/vcArcHYLvnBM7r7YbPu2vhxMidG9dD26RiY2nFTB6F+zVeLs?=
 =?us-ascii?Q?xSuxdWSZSOunhb+G1p8RG55uMRF75Zv3xbdi7sN0j5q2wcGmvyswk4S3Ww+B?=
 =?us-ascii?Q?gLJkzDPb3P8ldULZEXaqUI4i9ZpCGLWCu4whyLbmBJ3igGJmZKUSNJv/d516?=
 =?us-ascii?Q?hPC7msQLtWQYLfKR1To+mL91typ7nBy9kvZ2C0+M1BNwjYEqn5iOvcN4BHZe?=
 =?us-ascii?Q?RB5AwyyA0YGqpG0YICkAUB2JvwGHb3SNAUhE61PWo8kY2wEh+1pHhdfRcs4d?=
 =?us-ascii?Q?ACu/MbKy0P3i+SemJ6hhxtrtxwtgdrr6cQQDQFgiYyPyexSADjjFQxgmeHlf?=
 =?us-ascii?Q?Lxj1BgpxQyy7fP8CX/lpjeifX7PFmvKDsc34q3NJ9bQ17ZlKXQ/WmQL5KZID?=
 =?us-ascii?Q?9pSjol2ZibD3v3lN+HDVVa48Ti5+HptBwhb9cPjsbth4vkI6+jrMx821QQVB?=
 =?us-ascii?Q?L+3NcbibHxjNHsxntnQ6YKJzh0T1mfSKxo6sfWxGxlxf0ssCnG9qGNwih3TR?=
 =?us-ascii?Q?Gx8Ec4ZfDBmks1SzZ7/U99lEBvv/A7EldyZLw587IEFesyvlQRACCPK0C9qD?=
 =?us-ascii?Q?N3jqs0R963EqzuQkiT9Ahfw7zWLxUdUq+f2Wdx5KkaToLfhrzTkvVQ52CC6L?=
 =?us-ascii?Q?SvxLEiM+3Ui5kEZR8/zU3IXgxalHoHUFRhJoxGWjLIbf9Cdg7jCST6d1OV0o?=
 =?us-ascii?Q?obYEsArsdfiN0vWdSZY4RYobVWMD8jc4kbRcwhRJy8EFEEGw3JO8YMr0mQ8b?=
 =?us-ascii?Q?hZbn2Wnx2nkSA1ARwaUY8JvkwHrHxfNbw+gAjixNFKmaWzbzKxdSFr7jqRDG?=
 =?us-ascii?Q?09cEQGabm8jHzt92LZzrqaQXipoDl+Wen180WzQr21e8IqDRiZhO8BhLgXch?=
 =?us-ascii?Q?KuEfZ2gae5+9o29TJKdRO1VkJbmDgkszHFCR94qDge69qlAQkjrbvgupXC0r?=
 =?us-ascii?Q?A7CYJU55AAzygewgynylZeN8ZSU51XCibrfHecJIZDC72t3wBGv4exvoUDNI?=
 =?us-ascii?Q?l6DG1F/M5nH/69JuNt1skxb/cX+f+aeejvA5P0S8UnFmy2r68k3QDpCjY8Hm?=
 =?us-ascii?Q?dX6r2kJRQf4HevVRLQWQXQ+0byNTVlcPBNc5WWgGMwVLK4Kf45StnNl2XyEM?=
 =?us-ascii?Q?SiAV1JZLnH9uSODnDgvOF969oabpfKHYkTIWKGrfX09vlj4wlIdLWWyOCYe1?=
 =?us-ascii?Q?yZjna7HwYBNk1Gu6DRD+OB8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f36cb0d7-1874-4495-79ba-08d9df0ba95d
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 07:32:23.5151 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T/y0Sbd0xTaesgpzBVFLwqHzMhf42cgjx2AurYFCczLcwZuGqVlMhqLRmWmX8n6YKz57xie2efZHS5TaCgOmLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1273
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Liu,
 Aaron" <Aaron.Liu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jan 24, 2022 at 11:20:41AM +0800, Huang, Tim wrote:
> Use IP versions rather than asic_type to differentiate IP version specific features.
> 
> Signed-off-by: Tim Huang <xiaohu.huang@amd.com>

Reviewed-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> index 01c242c5abc3..c5ffb14ba183 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> @@ -50,11 +50,16 @@ static int jpeg_v3_0_early_init(void *handle)
>  {
>  	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>  
> -	if (adev->asic_type != CHIP_YELLOW_CARP) {
> -		u32 harvest = RREG32_SOC15(JPEG, 0, mmCC_UVD_HARVESTING);
> +	u32 harvest;
>  
> +	switch (adev->ip_versions[UVD_HWIP][0]) {
> +	case IP_VERSION(3, 1, 1): 
> +		break;
> +	default:
> +		harvest = RREG32_SOC15(JPEG, 0, mmCC_UVD_HARVESTING);
>  		if (harvest & CC_UVD_HARVESTING__UVD_DISABLE_MASK)
>  			return -ENOENT;
> +		break;
>  	}
>  
>  	adev->jpeg.num_jpeg_inst = 1;
> -- 
> 2.25.1
> 
