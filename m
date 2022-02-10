Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4B1AC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Feb 2022 04:48:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37ECD10E424;
	Thu, 10 Feb 2022 04:48:47 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7C5610E424
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Feb 2022 04:48:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DL7OlhFzZp9gLne6T3o9MIPb13fYMgIKjshvnIRbV3nVE9hG13yCY7xWSSlxhxYrvgbYi/mK0urCWeRadFJxX3ML0TIFADVBkF0YW6cePSiCSoXYqGMcF7poyBY9p+u5XYbWUx+9FtSKAS38JEtVtZRc5EmYT+cQeBmUfIi+pmGzzCBmX/xOp8AKsS2UBi42MglpMudpcDXrjYKHGyZsARU+Rrf++nB5VutE45FH/QXEfdKoKg1vjQV3/sTKa5Yp/4Jpl/Nc2KzTOFk5Wz3386M40c6qmOhuYInDSq25FDWmqPrCivt16J2sQtoSBLhobWJfHUTjPr0rnqgAsfkUgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8oyuNBIPN5Qs5uZINdxohKuqumlpR7t9IkIwIHPqIGg=;
 b=bsWeXU/UsPvuOPM+wsFP288RqeRXaQ5sOuablv9KfxwAhA8D9ctgKgm4ENJhh5IKERMEWlVzkzKgsoDLZ0GTlJk0xCCTKUATHDdgqYSn2QCMSjpT7sApSAiiQXvpkZxYh5DZeuTk+HNeOImkn+b06XMfD74+xz936wQ0wBuGAmY20TUYLdjatQEKeAX5R4K90vKRC/ogStX+FIhWIXoVgn0fsz96V7ow4g8K5ojaBaORd3QOUTjV/U3U+H+cT8SvYX1Yy6U09R39JYLzkFscYVM5vNe3p0/tEbk4R8eJI27D2rqymqZvktoSyfUt1cqqeF/t1IgOU0OIeWqsxGl/MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8oyuNBIPN5Qs5uZINdxohKuqumlpR7t9IkIwIHPqIGg=;
 b=sRyDP9oD0fo22bTMv5j3gRprRD7NFhM0yshujPBPoUOZfrAJ0ws3t8+PXIRjbPANILCGSfo72z4KOLhQ6MHPBUP38YbURUsULQFvHgu0GH1w1ko6kq8LpsamSKAvKmlhaR10nePNZwvIdhP6RPzJ4nMqr5Rt+f8NF72aPEUuNto=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 DS7PR12MB5792.namprd12.prod.outlook.com (2603:10b6:8:77::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.18; Thu, 10 Feb 2022 04:48:43 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::989c:5eff:f1be:c7ac]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::989c:5eff:f1be:c7ac%8]) with mapi id 15.20.4951.019; Thu, 10 Feb 2022
 04:48:43 +0000
Date: Thu, 10 Feb 2022 12:48:32 +0800
From: Lang Yu <Lang.Yu@amd.com>
To: Luben Tuikov <luben.tuikov@amd.com>
Subject: Re: [PATCH v1 1/1] drm/amdgpu: Show IP discovery in sysfs
Message-ID: <YgSZIBgQqa4qGsQR@lang-desktop>
References: <20220209225144.8433-1-luben.tuikov@amd.com>
 <20220209225144.8433-2-luben.tuikov@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209225144.8433-2-luben.tuikov@amd.com>
X-ClientProxiedBy: HK0PR03CA0098.apcprd03.prod.outlook.com
 (2603:1096:203:b0::14) To DM6PR12MB4250.namprd12.prod.outlook.com
 (2603:10b6:5:21a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5fe7996c-3519-4840-fe29-08d9ec509d9f
X-MS-TrafficTypeDiagnostic: DS7PR12MB5792:EE_
X-Microsoft-Antispam-PRVS: <DS7PR12MB5792B4FABC146CD7FCB4889BFB2F9@DS7PR12MB5792.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:386;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q+LTZfcaitrVACjPH7+bApHstozqj5vaZeBbyOpfya9apTzMEsNB0OEVzp+2gA8IOmcZC3C/xumYilpMZcNsgpYTpgsp3LPOBKAeuXCwVoBwF1CC0FGgv9ZO+tbjwH90GYuCnHQMOMaseI79vNYKrai+taBJnKw356wzjV13GUF5caJBArjlFz99NMVKrDwVbxt+0rWdU1w+DOUgqv/bzO1MTxBzvg/b84pEzaRMnd2bIMs2BeUvwdKjH3dn8Vzh4szOvEcwTth02hnCYiavjQKkmyeuni24Q2oyh3CHAkzLV3E31xBpfydl5e+NtmNcmwBSglF4/jY7Au7EkxST7+Xoj4mJWXBtnH1WSkaqiF0LLHKnskPSZLSQgwoOfbwJ/Hdlnx6jp60MuiKV+0uSY40kPSxdsMBFYvf2oDAFYn+d1VBGvama5G+XVLs1/eDKFYXFKZcKIS6Os5zZpYqRKF14i8coC+XdlI/gkWPAQozPEu3IAn+JBztxXc0KwiPx5DV1Gj/4jpHRl9MtjkvQBKldiqO/mCC/p6M8Nxy+lIQy7wmJ0mjleZ0JY2XgHYLorwN/i8ViNXn9gp+br4fuwAPDRE36zjC24qtC/Rp2TLwNrW0bTE7io1/2qT1IHoe9T4FchHNVvbh9DbMI8udgUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(7916004)(4636009)(366004)(33716001)(508600001)(316002)(30864003)(6486002)(6636002)(54906003)(6666004)(6506007)(9686003)(6512007)(8936002)(2906002)(8676002)(83380400001)(66556008)(66946007)(6862004)(26005)(186003)(5660300002)(4326008)(86362001)(66476007)(38100700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Rolajd8QTfnqojWxjldJ6UBlgIcR61gsUOdE9yXIygXYN9NWMy0+oBE9aDEV?=
 =?us-ascii?Q?6zXSROxU6jUQ6alSTXS7YNysYraU2ffHwIZXhsAZDmkFdiZg+QcugzgS79ms?=
 =?us-ascii?Q?RyfLwqn43g0ldpl4CpLS+pGWI/ZqkjvfabPDPOay3HApjNZ1rxhsnzad7vka?=
 =?us-ascii?Q?W475k/hb+IAzHGy+nh0BQAnES37yjmJCZnjM+k66KehfC0JiURDD1XbxQG7A?=
 =?us-ascii?Q?Dei/jKpvISe1zfMeHDQIPkxFNgiBbtGFOIQqtk08OKVhULBFKRj4pO0zEmAJ?=
 =?us-ascii?Q?UhSRk4HHrMOK3S801goGCq/E70skMHUJnAW+iRWE7QFCTSD7PzTGfrG230tl?=
 =?us-ascii?Q?I6RZS/HikcpoIb4lpuDg7JTPoLlM0RyADr/C0drEnVtp7QyaQgxKddcKDHMq?=
 =?us-ascii?Q?zTlwKxHPHjVhdvvd194QYBIPjfEi35ayXRMO4HTRklDS8H9x6aZSqy6ot73T?=
 =?us-ascii?Q?aoTwXbBhiDtNlrDZWzgrTJPD0KH6puZFdARWND0ek5D1RrFRSbGYZSOeGnt/?=
 =?us-ascii?Q?BM95aulCNNz3agoHKHhhlh4iOXC3nKHHl8x6TQdqsr2Ia94/S/7MU8B1yNLi?=
 =?us-ascii?Q?/cx89a6rbPG0GgjGffeHdN14XoCRDfiqWYB77Hz7Wm1PeMQOGdmuWm3q9K/c?=
 =?us-ascii?Q?h0/3emPw52AJepbJ/A4Qpit1O9XFh9nCeQazDDOkUWHyqRN885neQfh1a/wZ?=
 =?us-ascii?Q?uFAvhmnOs4oYVtSrLbbIjLFxiuT8Ttg5ZSRcZ7cM0F9RTqkXhqgPJz83AIW5?=
 =?us-ascii?Q?+Y1nyV4pWLL+RTnELDV5L8vr/a/KiQkGYiYBM/6x6MXcaGVt5Ha4EwQZ5omK?=
 =?us-ascii?Q?4E9hXRjhBT0ElANgjKg2/VbHK+HTUGFAYtv6YOQSvK8syjhoTjysuyf30XUY?=
 =?us-ascii?Q?WLgYPpEbcrjbRe/iVXGEVoj4tdvVuqzDLUF1gKA9oONT83EMFZvw2ptvG1oR?=
 =?us-ascii?Q?N+KeuONlAyQgN/DBskXc+aVeyrsftuFisEizNypZATv2R2dIPmlFW09ovjWS?=
 =?us-ascii?Q?l32Q3no9ovmrl8/jZFO94DTcb8eWrOmbI7aj62cPfdJJjs+L4ENZsWJqulq7?=
 =?us-ascii?Q?9RL7NfvKIM+b1KzGn0nxFovOIG9UAyHd3BOyrPj+vAEcZG0YsAfW8WGGxkAY?=
 =?us-ascii?Q?T3LwqVhC/pGdL3ioyR4eWYLNDw8u1DVc9c4sVaQmH8G8kv2vBSPzfVKHH2Ix?=
 =?us-ascii?Q?w/xx1ALPaKW53mXLsFvCOvKTj4iqMpizkgowxTE0+ei9W/vVbpog+Tuufkgc?=
 =?us-ascii?Q?jfdHGn0g2N4dHIIMJBQj40E0iTiVZ+yGFzOlq/HKnJylfqJ4dirc7VL/YVUH?=
 =?us-ascii?Q?74rzsrkJO+NDidZa7cfRoo/Sxr4CjbSkBoIvpOW771GS3NfA4an7xv2zLveM?=
 =?us-ascii?Q?+bJNPY8b3wnpTGwUJyTfme5OsyZj0ju0x+y9R51Nb4tj6UQU0AOLkhXOFxhM?=
 =?us-ascii?Q?hOz3pqsiHIShXK4q6CzS4woCK7KZR9oGVnakdBa3R9a8nEQvkHxAPtcIh4j4?=
 =?us-ascii?Q?xUgoj1rySih65wvQFaKJTogBWrjTeakoHRPf4ot2MDSoMhyCmSGwBViWBmgS?=
 =?us-ascii?Q?SE4Ih0yIKMhJKLk/Yw0PeqOX11icZKB10UyaxcUWiY4cnlr9wd3ZuU/l4pMN?=
 =?us-ascii?Q?GOm/0bFELytP6y/KznpQlfI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fe7996c-3519-4840-fe29-08d9ec509d9f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 04:48:43.7713 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rVINzHtjEiakoitIN6DIIuv/xtWfqfGA5cX7RnxPSQJVOhk2qxDf/xSLTDFVI0zoFQVLfsoo/SjrmlYGELaJXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5792
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>, Tom StDenis <tom.stdenis@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 02/09/ , Luben Tuikov wrote:
> Add IP discovery data in sysfs. The format is:
> /sys/class/drm/cardX/device/ip_discovery/die/D/B/I/<attrs>
> where,
> X is the card ID, an integer,
> D is the die ID, an integer,
> B is the IP HW ID, an integer, aka block type,
> I is the IP HW ID instance, an integer.
> <attrs> are the attributes of the block instance. At the moment these
> include HW ID, instance number, major, minor, revision, number of base
> addresses, and the base addresses themselves.
> 
> A symbolic link of the acronym HW ID is also created, under D/, if you
> prefer to browse by something humanly accessible.
> 
> Cc: Alex Deucher <Alexander.Deucher@amd.com>
> Cc: Tom StDenis <tom.stdenis@amd.com>
> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   4 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 486 ++++++++++++++++++
>  2 files changed, 490 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index e4eb812ade2fa4..3a126dce8a2fe9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -772,6 +772,8 @@ struct amd_powerplay {
>  	const struct amd_pm_funcs *pp_funcs;
>  };
>  
> +struct ip_discovery_top;
> +
>  /* polaris10 kickers */
>  #define ASICID_IS_P20(did, rid)		(((did == 0x67DF) && \
>  					 ((rid == 0xE3) || \
> @@ -1097,6 +1099,8 @@ struct amdgpu_device {
>  	bool				ram_is_direct_mapped;
>  
>  	struct list_head                ras_list;
> +
> +	struct ip_discovery_top         *ip_top;
>  };
>  
>  static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index 07623634fdc2f1..46e6e1352574f6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -360,8 +360,11 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
>  	return r;
>  }
>  
> +static void amdgpu_discovery_sysfs_fini(struct amdgpu_device *adev);
> +
>  void amdgpu_discovery_fini(struct amdgpu_device *adev)
>  {
> +	amdgpu_discovery_sysfs_fini(adev);
>  	kfree(adev->mman.discovery_bin);
>  	adev->mman.discovery_bin = NULL;
>  }
> @@ -382,6 +385,487 @@ static int amdgpu_discovery_validate_ip(const struct ip *ip)
>  	return 0;
>  }
>  
> +/* ================================================== */
> +
> +struct ip_hw_instance {
> +	struct kobject kobj; /* ip_discovery/die/#die/#hw_id/#instance/<attrs...> */
> +
> +	int hw_id;
> +	u8  num_instance;
> +	u8  major, minor, revision;
> +
> +	int num_base_addresses;
> +	u32 base_addr[0];
> +};
> +
> +struct ip_hw_id {
> +	struct kset hw_id_kset;  /* ip_discovery/die/#die/#hw_id/, contains ip_hw_instance */
> +	int hw_id;
> +};
> +
> +struct ip_die_entry {
> +	struct kset ip_kset;     /* ip_discovery/die/#die/, contains ip_hw_id  */
> +	u16 num_ips;
> +};
> +
> +/* -------------------------------------------------- */
> +
> +struct ip_hw_instance_attr {
> +	struct attribute attr;
> +	ssize_t (*show)(struct ip_hw_instance *ip_hw_instance, char *buf);
> +};
> +
> +static ssize_t hw_id_show(struct ip_hw_instance *ip_hw_instance, char *buf)
> +{
> +	return sprintf(buf, "%d\n", ip_hw_instance->hw_id);
> +}

It's better to use sysfs_emit() or sysfs_emit_at() in show()
per Documentation/filesystems/sysfs.rst.

Regards,
Lang
> +static ssize_t num_instance_show(struct ip_hw_instance *ip_hw_instance, char *buf)
> +{
> +	return sprintf(buf, "%d\n", ip_hw_instance->num_instance);
> +}
> +
> +static ssize_t major_show(struct ip_hw_instance *ip_hw_instance, char *buf)
> +{
> +	return sprintf(buf, "%d\n", ip_hw_instance->major);
> +}
> +
> +static ssize_t minor_show(struct ip_hw_instance *ip_hw_instance, char *buf)
> +{
> +	return sprintf(buf, "%d\n", ip_hw_instance->minor);
> +}
> +
> +static ssize_t revision_show(struct ip_hw_instance *ip_hw_instance, char *buf)
> +{
> +	return sprintf(buf, "%d\n", ip_hw_instance->revision);
> +}
> +
> +static ssize_t num_base_addresses_show(struct ip_hw_instance *ip_hw_instance, char *buf)
> +{
> +	return sprintf(buf, "%d\n", ip_hw_instance->num_base_addresses);
> +}
> +
> +static ssize_t base_addr_show(struct ip_hw_instance *ip_hw_instance, char *buf)
> +{
> +	ssize_t res = 0;
> +	int ii;
> +
> +	for (ii = 0; ii < ip_hw_instance->num_base_addresses; ii++) {
> +		if (res + 12 >= PAGE_SIZE)
> +			break;
> +		res += sprintf(buf + res, "0x%08X\n", ip_hw_instance->base_addr[ii]);
> +	}
> +
> +	return res;
> +}
> +
> +static struct ip_hw_instance_attr ip_hw_attr[] = {
> +	__ATTR_RO(hw_id),
> +	__ATTR_RO(num_instance),
> +	__ATTR_RO(major),
> +	__ATTR_RO(minor),
> +	__ATTR_RO(revision),
> +	__ATTR_RO(num_base_addresses),
> +	__ATTR_RO(base_addr),
> +};
> +
> +static struct attribute *ip_hw_instance_attrs[] = {
> +	&ip_hw_attr[0].attr,
> +	&ip_hw_attr[1].attr,
> +	&ip_hw_attr[2].attr,
> +	&ip_hw_attr[3].attr,
> +	&ip_hw_attr[4].attr,
> +	&ip_hw_attr[5].attr,
> +	&ip_hw_attr[6].attr,
> +	NULL,
> +};
> +ATTRIBUTE_GROUPS(ip_hw_instance);
> +
> +#define to_ip_hw_instance(x) container_of(x, struct ip_hw_instance, kobj)
> +#define to_ip_hw_instance_attr(x) container_of(x, struct ip_hw_instance_attr, attr)
> +
> +static ssize_t ip_hw_instance_attr_show(struct kobject *kobj,
> +					struct attribute *attr,
> +					char *buf)
> +{
> +	struct ip_hw_instance *ip_hw_instance = to_ip_hw_instance(kobj);
> +	struct ip_hw_instance_attr *ip_hw_attr = to_ip_hw_instance_attr(attr);
> +
> +	if (!ip_hw_attr->show)
> +		return -EIO;
> +
> +	return ip_hw_attr->show(ip_hw_instance, buf);
> +}
> +
> +static const struct sysfs_ops ip_hw_instance_sysfs_ops = {
> +	.show = ip_hw_instance_attr_show,
> +};
> +
> +static void ip_hw_instance_release(struct kobject *kobj)
> +{
> +	struct ip_hw_instance *ip_hw_instance = to_ip_hw_instance(kobj);
> +
> +	kfree(ip_hw_instance);
> +}
> +
> +static struct kobj_type ip_hw_instance_ktype = {
> +	.release = ip_hw_instance_release,
> +	.sysfs_ops = &ip_hw_instance_sysfs_ops,
> +	.default_groups = ip_hw_instance_groups,
> +};
> +
> +/* -------------------------------------------------- */
> +
> +#define to_ip_hw_id(x)  container_of(to_kset(x), struct ip_hw_id, hw_id_kset)
> +
> +static void ip_hw_id_release(struct kobject *kobj)
> +{
> +	struct ip_hw_id *ip_hw_id = to_ip_hw_id(kobj);
> +
> +	if (!list_empty(&ip_hw_id->hw_id_kset.list))
> +		DRM_ERROR("ip_hw_id->hw_id_kset is not empty");
> +	kfree(ip_hw_id);
> +}
> +
> +static struct kobj_type ip_hw_id_ktype = {
> +	.release = ip_hw_id_release,
> +	.sysfs_ops = &kobj_sysfs_ops,
> +};
> +
> +/* -------------------------------------------------- */
> +
> +static void die_kobj_release(struct kobject *kobj);
> +static void ip_disc_release(struct kobject *kobj);
> +
> +struct ip_die_entry_attribute {
> +	struct attribute attr;
> +	ssize_t (*show)(struct ip_die_entry *ip_die_entry, char *buf);
> +};
> +
> +#define to_ip_die_entry_attr(x)  container_of(x, struct ip_die_entry_attribute, attr)
> +
> +static ssize_t num_ips_show(struct ip_die_entry *ip_die_entry, char *buf)
> +{
> +	return sprintf(buf, "%d\n", ip_die_entry->num_ips);
> +}
> +
> +/* If there are more ip_die_entry attrs, other than the number of IPs,
> + * we can make this intro an array of attrs, and then initialize
> + * ip_die_entry_attrs in a loop.
> + */
> +static struct ip_die_entry_attribute num_ips_attr =
> +	__ATTR_RO(num_ips);
> +
> +static struct attribute *ip_die_entry_attrs[] = {
> +	&num_ips_attr.attr,
> +	NULL,
> +};
> +ATTRIBUTE_GROUPS(ip_die_entry); /* ip_die_entry_groups */
> +
> +#define to_ip_die_entry(x) container_of(to_kset(x), struct ip_die_entry, ip_kset)
> +
> +static ssize_t ip_die_entry_attr_show(struct kobject *kobj,
> +				      struct attribute *attr,
> +				      char *buf)
> +{
> +	struct ip_die_entry_attribute *ip_die_entry_attr = to_ip_die_entry_attr(attr);
> +	struct ip_die_entry *ip_die_entry = to_ip_die_entry(kobj);
> +
> +	if (!ip_die_entry_attr->show)
> +		return -EIO;
> +
> +	return ip_die_entry_attr->show(ip_die_entry, buf);
> +}
> +
> +static void ip_die_entry_release(struct kobject *kobj)
> +{
> +	struct ip_die_entry *ip_die_entry = to_ip_die_entry(kobj);
> +
> +	if (!list_empty(&ip_die_entry->ip_kset.list))
> +		DRM_ERROR("ip_die_entry->ip_kset is not empty");
> +	kfree(ip_die_entry);
> +}
> +
> +static const struct sysfs_ops ip_die_entry_sysfs_ops = {
> +	.show = ip_die_entry_attr_show,
> +};
> +
> +static struct kobj_type ip_die_entry_ktype = {
> +	.release = ip_die_entry_release,
> +	.sysfs_ops = &ip_die_entry_sysfs_ops,
> +	.default_groups = ip_die_entry_groups,
> +};
> +
> +static struct kobj_type die_kobj_ktype = {
> +	.release = die_kobj_release,
> +	.sysfs_ops = &kobj_sysfs_ops,
> +};
> +
> +static struct kobj_type ip_discovery_ktype = {
> +	.release = ip_disc_release,
> +	.sysfs_ops = &kobj_sysfs_ops,
> +};
> +
> +struct ip_discovery_top {
> +	struct kobject kobj;    /* ip_discovery/ */
> +	struct kset die_kset;   /* ip_discovery/die/, contains ip_die_entry */
> +	struct amdgpu_device *adev;
> +};
> +
> +static void die_kobj_release(struct kobject *kobj)
> +{
> +	struct ip_discovery_top *ip_top = container_of(to_kset(kobj),
> +						       struct ip_discovery_top,
> +						       die_kset);
> +	if (!list_empty(&ip_top->die_kset.list))
> +		DRM_ERROR("ip_top->die_kset is not empty");
> +}
> +
> +static void ip_disc_release(struct kobject *kobj)
> +{
> +	struct ip_discovery_top *ip_top = container_of(kobj, struct ip_discovery_top,
> +						       kobj);
> +	struct amdgpu_device *adev = ip_top->adev;
> +
> +	adev->ip_top = NULL;
> +	kfree(ip_top);
> +}
> +
> +static int amdgpu_discovery_sysfs_ips(struct amdgpu_device *adev,
> +				      struct ip_die_entry *ip_die_entry,
> +				      const size_t _ip_offset, const int num_ips)
> +{
> +	int ii, jj, kk, res;
> +
> +	DRM_DEBUG("num_ips:%d", num_ips);
> +
> +	/* Find all IPs of a given HW ID, and add their instance to
> +	 * #die/#hw_id/#instance/<attributes>
> +	 */
> +	for (ii = 0; ii < HW_ID_MAX; ii++) {
> +		struct ip_hw_id *ip_hw_id = NULL;
> +		size_t ip_offset = _ip_offset;
> +
> +		for (jj = 0; jj < num_ips; jj++) {
> +			struct ip *ip;
> +			struct ip_hw_instance *ip_hw_instance;
> +
> +			ip = (struct ip *)(adev->mman.discovery_bin + ip_offset);
> +			if (amdgpu_discovery_validate_ip(ip) ||
> +			    le16_to_cpu(ip->hw_id) != ii)
> +				goto next_ip;
> +
> +			DRM_DEBUG("match:%d @ ip_offset:%ld", ii, ip_offset);
> +
> +			/* We have a hw_id match; register the hw
> +			 * block if not yet registered.
> +			 */
> +			if (!ip_hw_id) {
> +				ip_hw_id = kzalloc(sizeof(*ip_hw_id), GFP_KERNEL);
> +				if (!ip_hw_id)
> +					return -ENOMEM;
> +				ip_hw_id->hw_id = ii;
> +
> +				kobject_set_name(&ip_hw_id->hw_id_kset.kobj, "%d", ii);
> +				ip_hw_id->hw_id_kset.kobj.kset = &ip_die_entry->ip_kset;
> +				ip_hw_id->hw_id_kset.kobj.ktype = &ip_hw_id_ktype;
> +				res = kset_register(&ip_hw_id->hw_id_kset);
> +				if (res) {
> +					DRM_ERROR("Couldn't register ip_hw_id kset");
> +					kfree(ip_hw_id);
> +					return res;
> +				}
> +				if (hw_id_names[ii]) {
> +					res = sysfs_create_link(&ip_die_entry->ip_kset.kobj,
> +								&ip_hw_id->hw_id_kset.kobj,
> +								hw_id_names[ii]);
> +					if (res) {
> +						DRM_ERROR("Couldn't create IP link %s in IP Die:%s\n",
> +							  hw_id_names[ii],
> +							  kobject_name(&ip_die_entry->ip_kset.kobj));
> +					}
> +				}
> +			}
> +
> +			/* Now register its instance.
> +			 */
> +			ip_hw_instance = kzalloc(sizeof(*ip_hw_instance) +
> +						 sizeof(u32) * ip->num_base_address,
> +						 GFP_KERNEL);
> +			if (!ip_hw_instance) {
> +				DRM_ERROR("no memory for ip_hw_instance");
> +				return -ENOMEM;
> +			}
> +			ip_hw_instance->hw_id = le16_to_cpu(ip->hw_id); /* == ii */
> +			ip_hw_instance->num_instance = ip->number_instance;
> +			ip_hw_instance->major = ip->major;
> +			ip_hw_instance->minor = ip->minor;
> +			ip_hw_instance->revision = ip->revision;
> +			ip_hw_instance->num_base_addresses = ip->num_base_address;
> +
> +			for (kk = 0; kk < ip_hw_instance->num_base_addresses; kk++)
> +				ip_hw_instance->base_addr[kk] = ip->base_address[kk];
> +
> +			kobject_init(&ip_hw_instance->kobj, &ip_hw_instance_ktype);
> +			ip_hw_instance->kobj.kset = &ip_hw_id->hw_id_kset;
> +			res = kobject_add(&ip_hw_instance->kobj, NULL,
> +					  "%d", ip_hw_instance->num_instance);
> +next_ip:
> +			ip_offset += sizeof(*ip) + 4 * (ip->num_base_address - 1);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int amdgpu_discovery_sysfs_recurse(struct amdgpu_device *adev)
> +{
> +	struct binary_header *bhdr;
> +	struct ip_discovery_header *ihdr;
> +	struct die_header *dhdr;
> +	struct kset *die_kset = &adev->ip_top->die_kset;
> +	u16 num_dies, die_offset, num_ips;
> +	size_t ip_offset;
> +	int ii, res;
> +
> +	bhdr = (struct binary_header *)adev->mman.discovery_bin;
> +	ihdr = (struct ip_discovery_header *)(adev->mman.discovery_bin +
> +					      le16_to_cpu(bhdr->table_list[IP_DISCOVERY].offset));
> +	num_dies = le16_to_cpu(ihdr->num_dies);
> +
> +	DRM_DEBUG("number of dies: %d\n", num_dies);
> +
> +	for (ii = 0; ii < num_dies; ii++) {
> +		struct ip_die_entry *ip_die_entry;
> +
> +		die_offset = le16_to_cpu(ihdr->die_info[ii].die_offset);
> +		dhdr = (struct die_header *)(adev->mman.discovery_bin + die_offset);
> +		num_ips = le16_to_cpu(dhdr->num_ips);
> +		ip_offset = die_offset + sizeof(*dhdr);
> +
> +		/* Add the die to the kset.
> +		 *
> +		 * dhdr->die_id == ii, which was checked in
> +		 * amdgpu_discovery_reg_base_init().
> +		 */
> +
> +		ip_die_entry = kzalloc(sizeof(*ip_die_entry), GFP_KERNEL);
> +		if (!ip_die_entry)
> +			return -ENOMEM;
> +
> +		ip_die_entry->num_ips = num_ips;
> +
> +		kobject_set_name(&ip_die_entry->ip_kset.kobj, "%d", le16_to_cpu(dhdr->die_id));
> +		ip_die_entry->ip_kset.kobj.kset = die_kset;
> +		ip_die_entry->ip_kset.kobj.ktype = &ip_die_entry_ktype;
> +		res = kset_register(&ip_die_entry->ip_kset);
> +		if (res) {
> +			DRM_ERROR("Couldn't register ip_die_entry kset");
> +			kfree(ip_die_entry);
> +			return res;
> +		}
> +
> +		amdgpu_discovery_sysfs_ips(adev, ip_die_entry, ip_offset, num_ips);
> +	}
> +
> +	return 0;
> +}
> +
> +static int amdgpu_discovery_sysfs_init(struct amdgpu_device *adev)
> +{
> +	struct kset *die_kset;
> +	int res;
> +
> +	adev->ip_top = kzalloc(sizeof(*adev->ip_top), GFP_KERNEL);
> +	if (!adev->ip_top)
> +		return -ENOMEM;
> +
> +	adev->ip_top->adev = adev;
> +
> +	res = kobject_init_and_add(&adev->ip_top->kobj, &ip_discovery_ktype,
> +				   &adev->dev->kobj, "ip_discovery");
> +	if (res) {
> +		DRM_ERROR("Couldn't init and add ip_discovery/");
> +		goto Err;
> +	}
> +
> +	die_kset = &adev->ip_top->die_kset;
> +	kobject_set_name(&die_kset->kobj, "%s", "die");
> +	die_kset->kobj.parent = &adev->ip_top->kobj;
> +	die_kset->kobj.ktype = &die_kobj_ktype;
> +	res = kset_register(&adev->ip_top->die_kset);
> +	if (res) {
> +		DRM_ERROR("Couldn't register die_kset");
> +		goto Err;
> +	}
> +
> +	res = amdgpu_discovery_sysfs_recurse(adev);
> +
> +	return res;
> +Err:
> +	kobject_put(&adev->ip_top->kobj);
> +	return res;
> +}
> +
> +/* -------------------------------------------------- */
> +
> +#define list_to_kobj(el) container_of(el, struct kobject, entry)
> +
> +static void amdgpu_discovery_sysfs_ip_hw_free(struct ip_hw_id *ip_hw_id)
> +{
> +	struct list_head *el, *tmp;
> +	struct kset *hw_id_kset;
> +
> +	hw_id_kset = &ip_hw_id->hw_id_kset;
> +	spin_lock(&hw_id_kset->list_lock);
> +	list_for_each_prev_safe(el, tmp, &hw_id_kset->list) {
> +		list_del_init(el);
> +		spin_unlock(&hw_id_kset->list_lock);
> +		/* kobject is embedded in ip_hw_instance */
> +		kobject_put(list_to_kobj(el));
> +		spin_lock(&hw_id_kset->list_lock);
> +	}
> +	spin_unlock(&hw_id_kset->list_lock);
> +	kobject_put(&ip_hw_id->hw_id_kset.kobj);
> +}
> +
> +static void amdgpu_discovery_sysfs_die_free(struct ip_die_entry *ip_die_entry)
> +{
> +	struct list_head *el, *tmp;
> +	struct kset *ip_kset;
> +
> +	ip_kset = &ip_die_entry->ip_kset;
> +	spin_lock(&ip_kset->list_lock);
> +	list_for_each_prev_safe(el, tmp, &ip_kset->list) {
> +		list_del_init(el);
> +		spin_unlock(&ip_kset->list_lock);
> +		amdgpu_discovery_sysfs_ip_hw_free(to_ip_hw_id(list_to_kobj(el)));
> +		spin_lock(&ip_kset->list_lock);
> +	}
> +	spin_unlock(&ip_kset->list_lock);
> +	kobject_put(&ip_die_entry->ip_kset.kobj);
> +}
> +
> +static void amdgpu_discovery_sysfs_fini(struct amdgpu_device *adev)
> +{
> +	struct list_head *el, *tmp;
> +	struct kset *die_kset;
> +
> +	die_kset = &adev->ip_top->die_kset;
> +	spin_lock(&die_kset->list_lock);
> +	list_for_each_prev_safe(el, tmp, &die_kset->list) {
> +		list_del_init(el);
> +		spin_unlock(&die_kset->list_lock);
> +		amdgpu_discovery_sysfs_die_free(to_ip_die_entry(list_to_kobj(el)));
> +		spin_lock(&die_kset->list_lock);
> +	}
> +	spin_unlock(&die_kset->list_lock);
> +	kobject_put(&adev->ip_top->die_kset.kobj);
> +	kobject_put(&adev->ip_top->kobj);
> +}
> +
> +/* ================================================== */
> +
>  int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
>  {
>  	struct binary_header *bhdr;
> @@ -492,6 +976,8 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
>  		}
>  	}
>  
> +	amdgpu_discovery_sysfs_init(adev);
> +
>  	return 0;
>  }
>  
> -- 
> 2.35.0.3.gb23dac905b
> 
