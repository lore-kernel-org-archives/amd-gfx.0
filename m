Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B70C6C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Jan 2022 16:42:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F4D110E1A4;
	Tue, 25 Jan 2022 16:42:38 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2077.outbound.protection.outlook.com [40.107.100.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86DAE10E1A4
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Jan 2022 16:42:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mSTnfIxPxGw+jYNKHEcaMBWr7S/R+1HGIOHGtsi2c0157xhaaKRRy6T+3oGQbrc/xJ8CWavMzz8cCBKxq/mPcKCRrpgIPVUBb3AJcjJAWPXBImVz/2wubqCznHvOTE844NKg/QtXqnTrHlLbwniOC17kvmwiwJai7p1z9t9UGqJRcDG0YX6hdnsjwQArvBo/CNKIATbMAuJeCgr+7THIzAYrjnl4RWnga+OJioCsBrk8bblFzFDRLK9Cid19Yj6vJlgyVTBrE/kBRAYk49h2vz5F9OmPx8LsH3X6MKc5bkC0Jo1FDMpC/Pwg3o5I48CRe6/GlTGrn0gRL3rbZVPZag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G4IKLLd0s/XmNCMytQb9tzGdy6JvzUvdtnh6M4YcZ5s=;
 b=mkdKoVtuLCu3GqWjFmyiEtytzzqv7s//YnQwt+H5HVvHWB2uAAwmbo3hTnuL9BCPZLC+ITaRf54KGsw+p16lWOsFarvJaukaXP9l8zvGg/hdDLiOsud85oAYIfQl6ZI+a7cL1DnRMiVUWlmB/ahzC+6h3eJxtVO11Of/xcw3SIIESAdRWy3IKWubtU+hvrShRmEPueRY+0Nfnilsg2I6o5ATe+PO9AX9+WKzu5jkhfqBsoiuw0JxS+l1k4ZiFYiMn3Y0+R4/2ypa+vPxmwCzc4bqw9nLIOaArXU3knbvFO8QI685QyR0C4o5aO/VVT+ytx6Dah94JOSxdwnewMXSaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G4IKLLd0s/XmNCMytQb9tzGdy6JvzUvdtnh6M4YcZ5s=;
 b=0Vuu+WMCfFTr/zvv6IhpbO0Juz2p67CZvHJfbTKNQ6ZUmw3BeFtk3f6TH+9NdzHpRl7ohD82dcwa3wOoYmyzXUNza6q5it/6xVW4u1Fe/PMs8Td92FziHnBAr0BSI9MM3m+9M4OYXymgiZhkTv6VdxTtYJQcjSoBqZQW2Nm28GM=
Received: from DM6PR12MB3547.namprd12.prod.outlook.com (2603:10b6:5:18a::20)
 by BN7PR12MB2788.namprd12.prod.outlook.com (2603:10b6:408:30::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Tue, 25 Jan
 2022 16:42:13 +0000
Received: from DM6PR12MB3547.namprd12.prod.outlook.com
 ([fe80::d4e4:8282:5f20:c812]) by DM6PR12MB3547.namprd12.prod.outlook.com
 ([fe80::d4e4:8282:5f20:c812%4]) with mapi id 15.20.4909.017; Tue, 25 Jan 2022
 16:42:13 +0000
From: "StDenis, Tom" <Tom.StDenis@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: Add ip_discovery_text sysfs entry
Thread-Topic: [PATCH] drm/amd/amdgpu: Add ip_discovery_text sysfs entry
Thread-Index: AQHYEU1Jdun6vIVQgUCSIYi61/Ngi6xz8b8AgAAAYzs=
Date: Tue, 25 Jan 2022 16:42:13 +0000
Message-ID: <DM6PR12MB3547A57A5019D763E35091E4F75F9@DM6PR12MB3547.namprd12.prod.outlook.com>
References: <20220124180736.2646458-1-tom.stdenis@amd.com>
 <CADnq5_P66evR0jLhVOg7DmmKbD=xJ-gym0id9ud=s6PTT04G9A@mail.gmail.com>
In-Reply-To: <CADnq5_P66evR0jLhVOg7DmmKbD=xJ-gym0id9ud=s6PTT04G9A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 03e27d8f-5805-49a7-5711-08d9e021a3ae
x-ms-traffictypediagnostic: BN7PR12MB2788:EE_
x-microsoft-antispam-prvs: <BN7PR12MB27884BF0B3B5221932FEA552F75F9@BN7PR12MB2788.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BAOC665rEan5KDAPjju/5bPQZti2/+GeWrvR2lU1ouFwXrW4WweCDxoFZgYTSiEy6JQXv20La/Y2y7Wn17Hx73Gxkik3+mXa1+gSMlAvKqLbn8wZTVSYXyvdq2KzFrW4h/Y2JilVOpKXJCxMWhuv9xjfNcQVMAHI3DP1m6HASh2I+CMiSfuA/Oc4TYsC7B7nI9Y3brIDAmMCLjadJ8kdz0XnW173DtXQWlu/yfzeTMtfS/An8XV4FZKiqH12HabkGcrwxk6QMZzeUiPHRWkGTKZ2Xxkz1bpqajN9KphnRJV32YAF0ryJX16sOU/ta5Eh0mXpu69tN+f0/2NXD3UeK+CmNTVQ9JCnsM2eRovbFr0xE8Stj1hyjV7+iMQ3BinPTreR9/VxJLaKjWx9SodLqmCDQ+x57igUXS2G7z5WmpUg/b4yyBRdEiv4Tt1W7UPIJNpByaUDLcrCpB1V9OuJDaiwu0KRLz1bmDbuN6z7Y/c5jXZkGHbH3Yr74Uwz1/Jr49IZmMk/flvybYXP6JQAIpSvMrCdWc+TWT3urEULRN4POw8rA0vjSJ5UXTQ1fDKAJLJvGMy27JFLDycIkD/hmQJfRFi1Irh72EMQ1DBO6AATWXTBzoW4+VEqCY2ErOBLQ/tcR+kb5DlMgigKfv1fB7oWqNrF6KPMte6dkt9Au3eb4w/UyBJMenVkKme0dTZNzl7Ou6+5hC2dN48ndL3Zhw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3547.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(76116006)(66946007)(53546011)(66446008)(64756008)(38070700005)(66556008)(66476007)(5660300002)(52536014)(91956017)(4326008)(33656002)(508600001)(6506007)(7696005)(38100700002)(8936002)(186003)(86362001)(122000001)(6916009)(2906002)(55016003)(71200400001)(316002)(8676002)(26005)(9686003)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ELtyYJtkOKy6o9EFcXnt/l0dSwth4wH7bAWgSmcrPkHrtqy4n0E2/PNzdMAb?=
 =?us-ascii?Q?mIUeoQrXhODHflncCsmFXMXR9NoWQORmlL1MwOxALqyut6IVwnaUBQpJa4WS?=
 =?us-ascii?Q?P1x4JLpOCj74KpU9DDV7Gb4bLluHF6lSD4KaUdalg9lYpnT4NsXaWajqZSO+?=
 =?us-ascii?Q?zdXPb6ZJaZCkI0VoPhb/ZqJSnjzq2stb+i7BGhh7Agb3a1HKnphYQyCf/RNJ?=
 =?us-ascii?Q?5p6LdBrD4tpSSZczC1XeG8keV78z+w6LCzWiyyF0NDWZJR3zdxVPfMxAaKQa?=
 =?us-ascii?Q?rEmTM4bF7t8UdXYjfZEMdIJzgC/w6Qoi/QTal2YkXsKcVCECj5wGdEn1qKWN?=
 =?us-ascii?Q?6+hTif1tRp3e7Xqj78f7HXBI2Y/QpvDe+FjcwpSOUxecwgXOpQt/CzWBwlkR?=
 =?us-ascii?Q?R8hCn36QqAs50W05FPcYwCBgsK9wj8BqNandyjulvxQJGyPgJ6XJoVhxW0K1?=
 =?us-ascii?Q?iuJ0LksNkY7aKSG7f4APl5d+4AeX54N+OpTb0/Me6Wdog6be8hny/MlYfnFw?=
 =?us-ascii?Q?OZjrdmhW8UHTd+fL216XoZGoUfgwwWw8BK5BrHDfcAMIU38KO5emLqnpFo7M?=
 =?us-ascii?Q?JxfKPESAknxZwd0kvcsqnEvVoybuIgAPMeCPWGnSq937lnyAI7PzCU7eow6W?=
 =?us-ascii?Q?4U+AGzGXc1z452uqw7/f7t/bi14lTJ0X3JJ1xc3D7ywnGG78WxnaQte6xxof?=
 =?us-ascii?Q?sQx2niA0CyBJDa2yvEgwRQ1TJ7vtjTzYwLAVcj2gULGAsKewRZd93VLZ9/wN?=
 =?us-ascii?Q?Pk06Cs9EIynv8shonP0lXlxQy0JCoygHhoCp1zZpUDj4Ayv8Wx4emG0VYQVv?=
 =?us-ascii?Q?r0zw9pRb9PMt7onbW3aTGdhSiHWatHWJCGpPgUO8VuL+VpM80f0bmGA6g+Wh?=
 =?us-ascii?Q?HPhVCK7qfrunbyGeyZ2A6176YSnZGogGKt8WyjJOFDt316sGZnvzLFIqzYdd?=
 =?us-ascii?Q?9C6fu459h/MDoB2c+t9kxt+tcMOu9PjhtmY3f2zvDc31JcHurTHBD77VCqoE?=
 =?us-ascii?Q?S42juLT8epqpvkpAPHSNg66oMiOwrSiejvqtYQrFw40qdincaB0ebLloOPF+?=
 =?us-ascii?Q?ZMwU4ebf34boB1/F62JKtZKMOPC1ecHq65310sX8OAXrbGXj0j9q3UzVSlgD?=
 =?us-ascii?Q?MHzMDgFAg3sp4hmcdoiLBab+tFGyPC4oakQv4Tj9BrxtxeAOXYosxIjKZ2G8?=
 =?us-ascii?Q?XY7XvKsU/ZsMZ0+JZQ5LJvPP2IHUMX9KLnTR5vfRH4YTCLeU8v936HcV0cyO?=
 =?us-ascii?Q?v3kiEfVZAVb3iK8NE6X+ZrNOjTQYpF3BQ0XK5rJ1BS8PKZs2s8GUXQcVdvNk?=
 =?us-ascii?Q?0Jdxk6oqWbAqONlQj1s4s8kfc56j4W9d01MBrdoQLMh5gDksCiVQICuZLH7k?=
 =?us-ascii?Q?DK38npEsvwAGyU2zUOQzvbehbbhCOp58xewP1RTtnLsRNNAKF59fxv05CkvF?=
 =?us-ascii?Q?HClpSTyemu1LU0Pfff1XuFqgb6RZh55HqPmZvq+EXmUs99hotf+AruzKFOVD?=
 =?us-ascii?Q?Dbv5A41bL7t6vpQEIFeLJtA330dkVRU53dSOkg7iz5ZlZisQlg8azS4ryg2D?=
 =?us-ascii?Q?DIQx0Om5unptf+CGmbwZ+4DFgKrioxXPpvahbpl1fZpQQjg7AePObta57R4g?=
 =?us-ascii?Q?GQ=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM6PR12MB3547A57A5019D763E35091E4F75F9DM6PR12MB3547namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3547.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03e27d8f-5805-49a7-5711-08d9e021a3ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2022 16:42:13.3040 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z6i2QmRvMZgHhQnnMdnqCJ6z2irMf1Nc8a8dPtAeupfdatiIRjz6LUmUlxX/UtR2kdUpipd0o0WyJR51EJI8Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2788
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_DM6PR12MB3547A57A5019D763E35091E4F75F9DM6PR12MB3547namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I literally brought this up in our initial discussion....

Frankly from umrs point of view a single file is easier.

But I can't code anything until it's in the tree...


Tom




________________________________
From: Alex Deucher <alexdeucher@gmail.com>
Sent: Tuesday, January 25, 2022 11:39
To: StDenis, Tom <Tom.StDenis@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/amdgpu: Add ip_discovery_text sysfs entry

On Mon, Jan 24, 2022 at 1:07 PM Tom St Denis <tom.stdenis@amd.com> wrote:
>
> Newer hardware has a discovery table in hardware that the kernel will
> rely on instead of header files for things like IP offsets.  This
> sysfs entry adds a simple to parse table of IP instances and segment
> offsets.
>
> Produces output that looks like:
>
> $ cat ip_discovery_text
> ATHUB{0} v2.0.0: 00000c00 02408c00
> CLKA{0} v11.0.0: 00016c00 02401800
> CLKA{1} v11.0.0: 00016e00 02401c00
> CLKA{2} v11.0.0: 00017000 02402000
> CLKA{3} v11.0.0: 00017200 02402400
> CLKA{4} v11.0.0: 0001b000 0242d800
> CLKB{0} v11.0.0: 00017e00 0240bc00
> DBGU_NBIO{0} v3.0.0: 000001c0 02409000
> DBGU0{0} v3.0.0: 00000180 02409800
> DBGU1{0} v3.0.0: 000001a0 02409c00
> DF{0} v3.0.0: 00007000 0240b800
> DFX{0} v4.1.0: 00000580 02409400
> DFX_DAP{0} v2.0.0: 000005a0 00b80000 0240c400
> DMU{0} v2.0.2: 00000012 000000c0 000034c0 00009000 02403c00
> FUSE{0} v11.0.0: 00017400 02401400
> GC{0} v10.1.10: 00001260 0000a000 02402c00

I'm not opposed to this, but the general rule is one value per file
with sysfs.  Maybe something like:

$ ls ip_discovery
ATHUB CLKA CLKB DBGU_NBIO DBGU0 DBGU1
$ ls ip_discovery/CLKA
0 1 2 3 4
$ ls ip_discovery/CLKA/0
version offset0 offset1

Alex

>
> Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 77 ++++++++++++++++++-
>  2 files changed, 77 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index 3bc76759c143..6920f73bbe73 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1019,6 +1019,7 @@ struct amdgpu_device {
>         struct amdgpu_ip_block          ip_blocks[AMDGPU_MAX_IP_NUM];
>         uint32_t                        harvest_ip_mask;
>         int                             num_ip_blocks;
> +       char                    *ip_discovery_text;
>         struct mutex    mn_lock;
>         DECLARE_HASHTABLE(mn_hash, 7);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_discovery.c
> index 285811509d94..c64cab0ad18e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -267,6 +267,19 @@ static void amdgpu_discovery_harvest_config_quirk(st=
ruct amdgpu_device *adev)
>         }
>  }
>
> +static ssize_t ip_discovery_text_show(struct device *dev,
> +               struct device_attribute *attr, char *buf)
> +{
> +       struct drm_device *ddev =3D dev_get_drvdata(dev);
> +       struct amdgpu_device *adev =3D drm_to_adev(ddev);
> +
> +       return sysfs_emit(buf, "%s", adev->ip_discovery_text);
> +}
> +
> +static DEVICE_ATTR(ip_discovery_text, S_IRUGO,
> +                               ip_discovery_text_show, NULL);
> +
> +
>  static int amdgpu_discovery_init(struct amdgpu_device *adev)
>  {
>         struct table_info *info;
> @@ -351,6 +364,11 @@ static int amdgpu_discovery_init(struct amdgpu_devic=
e *adev)
>                 goto out;
>         }
>
> +       // init sysfs for ip_discovery
> +       r =3D sysfs_create_file(&adev->dev->kobj, &dev_attr_ip_discovery_=
text.attr);
> +       if (r)
> +               dev_err(adev->dev, "Could not create amdgpu device attr\n=
");
> +
>         return 0;
>
>  out:
> @@ -363,7 +381,11 @@ static int amdgpu_discovery_init(struct amdgpu_devic=
e *adev)
>  void amdgpu_discovery_fini(struct amdgpu_device *adev)
>  {
>         kfree(adev->mman.discovery_bin);
> +       kfree(adev->ip_discovery_text);
> +       sysfs_remove_file(&adev->dev->kobj, &dev_attr_ip_discovery_text.a=
ttr);
> +
>         adev->mman.discovery_bin =3D NULL;
> +       adev->ip_discovery_text =3D NULL;
>  }
>
>  static int amdgpu_discovery_validate_ip(const struct ip *ip)
> @@ -382,6 +404,20 @@ static int amdgpu_discovery_validate_ip(const struct=
 ip *ip)
>         return 0;
>  }
>
> +static int add_string(char **dst, unsigned *size, char *src)
> +{
> +       if (strlen(src) + strlen(*dst) >=3D *size) {
> +               void *tmp =3D krealloc(*dst, *size + 4096, GFP_KERNEL);
> +               if (!tmp) {
> +                       return -1;
> +               }
> +               *dst =3D tmp;
> +               *size =3D *size + 4096;
> +       }
> +       strcat(*dst, src);
> +       return 0;
> +}
> +
>  int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
>  {
>         struct binary_header *bhdr;
> @@ -396,6 +432,8 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_devi=
ce *adev)
>         int hw_ip;
>         int i, j, k;
>         int r;
> +       unsigned txt_size =3D 4096;
> +       char *linebuf;
>
>         r =3D amdgpu_discovery_init(adev);
>         if (r) {
> @@ -410,6 +448,15 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_dev=
ice *adev)
>
>         DRM_DEBUG("number of dies: %d\n", num_dies);
>
> +       adev->ip_discovery_text =3D kzalloc(txt_size, GFP_KERNEL);
> +       linebuf =3D kzalloc(4096, GFP_KERNEL);
> +       if (!adev->ip_discovery_text || !linebuf) {
> +               DRM_ERROR("Out of memory\n");
> +               kfree(linebuf);
> +               kfree(adev->ip_discovery_text);
> +               return -ENOMEM;
> +       }
> +
>         for (i =3D 0; i < num_dies; i++) {
>                 die_offset =3D le16_to_cpu(ihdr->die_info[i].die_offset);
>                 dhdr =3D (struct die_header *)(adev->mman.discovery_bin +=
 die_offset);
> @@ -419,6 +466,8 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_devi=
ce *adev)
>                 if (le16_to_cpu(dhdr->die_id) !=3D i) {
>                         DRM_ERROR("invalid die id %d, expected %d\n",
>                                         le16_to_cpu(dhdr->die_id), i);
> +                       kfree(linebuf);
> +                       kfree(adev->ip_discovery_text);
>                         return -EINVAL;
>                 }
>
> @@ -458,6 +507,19 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_dev=
ice *adev)
>                             le16_to_cpu(ip->hw_id) =3D=3D SDMA3_HWID)
>                                 adev->sdma.num_instances++;
>
> +                       snprintf(linebuf, 4096, "%s{%d} v%d.%d.%d: ",
> +                                 hw_id_names[le16_to_cpu(ip->hw_id)],
> +                                 ip->number_instance,
> +                                 ip->major, ip->minor,
> +                                 ip->revision);
> +                       if (add_string(&adev->ip_discovery_text, &txt_siz=
e, linebuf)) {
> +                               DRM_ERROR("Out of memory\n");
> +                               kfree(linebuf);
> +                               kfree(adev->ip_discovery_text);
> +                               return -ENOMEM;
> +                       }
> +
> +
>                         for (k =3D 0; k < num_base_address; k++) {
>                                 /*
>                                  * convert the endianness of base address=
es in place,
> @@ -465,6 +527,19 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_dev=
ice *adev)
>                                  */
>                                 ip->base_address[k] =3D le32_to_cpu(ip->b=
ase_address[k]);
>                                 DRM_DEBUG("\t0x%08x\n", ip->base_address[=
k]);
> +                               snprintf(linebuf, 4096, "%08lx ", (unsign=
ed long)ip->base_address[k]);
> +                               if (add_string(&adev->ip_discovery_text, =
&txt_size, linebuf)) {
> +                                       DRM_ERROR("Out of memory\n");
> +                                       kfree(linebuf);
> +                                       kfree(adev->ip_discovery_text);
> +                                       return -ENOMEM;
> +                               }
> +                       }
> +                       if (add_string(&adev->ip_discovery_text, &txt_siz=
e, "\n")) {
> +                               DRM_ERROR("Out of memory\n");
> +                               kfree(linebuf);
> +                               kfree(adev->ip_discovery_text);
> +                               return -ENOMEM;
>                         }
>
>                         for (hw_ip =3D 0; hw_ip < MAX_HWIP; hw_ip++) {
> @@ -491,7 +566,7 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_devi=
ce *adev)
>                         ip_offset +=3D sizeof(*ip) + 4 * (ip->num_base_ad=
dress - 1);
>                 }
>         }
> -
> +       kfree(linebuf);
>         return 0;
>  }
>
> --
> 2.32.0
>

--_000_DM6PR12MB3547A57A5019D763E35091E4F75F9DM6PR12MB3547namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<div>I literally brought this up in our initial discussion....</div>
<div><br>
</div>
<div>Frankly from umrs point of view a single file is easier.</div>
<div><br>
</div>
<div>But I can't code anything until it's in the tree...</div>
<div><br>
</div>
<div><br>
</div>
<div>Tom</div>
<div><br>
</div>
<div><br>
</div>
<div><br>
</div>
<div>
<div style=3D"font-family:Tahoma; font-size:13px"><br>
</div>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Alex Deucher &lt;alex=
deucher@gmail.com&gt;<br>
<b>Sent:</b> Tuesday, January 25, 2022 11:39<br>
<b>To:</b> StDenis, Tom &lt;Tom.StDenis@amd.com&gt;<br>
<b>Cc:</b> amd-gfx list &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amd/amdgpu: Add ip_discovery_text sysfs ent=
ry</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On Mon, Jan 24, 2022 at 1:07 PM Tom St Denis &lt;t=
om.stdenis@amd.com&gt; wrote:<br>
&gt;<br>
&gt; Newer hardware has a discovery table in hardware that the kernel will<=
br>
&gt; rely on instead of header files for things like IP offsets.&nbsp; This=
<br>
&gt; sysfs entry adds a simple to parse table of IP instances and segment<b=
r>
&gt; offsets.<br>
&gt;<br>
&gt; Produces output that looks like:<br>
&gt;<br>
&gt; $ cat ip_discovery_text<br>
&gt; ATHUB{0} v2.0.0: 00000c00 02408c00<br>
&gt; CLKA{0} v11.0.0: 00016c00 02401800<br>
&gt; CLKA{1} v11.0.0: 00016e00 02401c00<br>
&gt; CLKA{2} v11.0.0: 00017000 02402000<br>
&gt; CLKA{3} v11.0.0: 00017200 02402400<br>
&gt; CLKA{4} v11.0.0: 0001b000 0242d800<br>
&gt; CLKB{0} v11.0.0: 00017e00 0240bc00<br>
&gt; DBGU_NBIO{0} v3.0.0: 000001c0 02409000<br>
&gt; DBGU0{0} v3.0.0: 00000180 02409800<br>
&gt; DBGU1{0} v3.0.0: 000001a0 02409c00<br>
&gt; DF{0} v3.0.0: 00007000 0240b800<br>
&gt; DFX{0} v4.1.0: 00000580 02409400<br>
&gt; DFX_DAP{0} v2.0.0: 000005a0 00b80000 0240c400<br>
&gt; DMU{0} v2.0.2: 00000012 000000c0 000034c0 00009000 02403c00<br>
&gt; FUSE{0} v11.0.0: 00017400 02401400<br>
&gt; GC{0} v10.1.10: 00001260 0000a000 02402c00<br>
<br>
I'm not opposed to this, but the general rule is one value per file<br>
with sysfs.&nbsp; Maybe something like:<br>
<br>
$ ls ip_discovery<br>
ATHUB CLKA CLKB DBGU_NBIO DBGU0 DBGU1<br>
$ ls ip_discovery/CLKA<br>
0 1 2 3 4<br>
$ ls ip_discovery/CLKA/0<br>
version offset0 offset1<br>
<br>
Alex<br>
<br>
&gt;<br>
&gt; Signed-off-by: Tom St Denis &lt;tom.stdenis@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 1 +<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 77 +++++++++++++=
+++++-<br>
&gt;&nbsp; 2 files changed, 77 insertions(+), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu.h<br>
&gt; index 3bc76759c143..6920f73bbe73 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt; @@ -1019,6 +1019,7 @@ struct amdgpu_device {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ip_block=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ip_blocks[AMDGPU_MAX=
_IP_NUM];<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; harvest_ip_mask;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
num_ip_blocks;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; *ip_discovery_text;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mutex&nbsp;&nbs=
p;&nbsp; mn_lock;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DECLARE_HASHTABLE(mn_h=
ash, 7);<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_discovery.c<br>
&gt; index 285811509d94..c64cab0ad18e 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c<br>
&gt; @@ -267,6 +267,19 @@ static void amdgpu_discovery_harvest_config_quirk=
(struct amdgpu_device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp; }<br>
&gt;<br>
&gt; +static ssize_t ip_discovery_text_show(struct device *dev,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct device_attribute *attr, char *buf)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *ddev =3D dev_=
get_drvdata(dev);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D d=
rm_to_adev(ddev);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return sysfs_emit(buf, &quot;%s&=
quot;, adev-&gt;ip_discovery_text);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static DEVICE_ATTR(ip_discovery_text, S_IRUGO,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ip_discovery_text_show, NULL);<br>
&gt; +<br>
&gt; +<br>
&gt;&nbsp; static int amdgpu_discovery_init(struct amdgpu_device *adev)<br>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct table_info *inf=
o;<br>
&gt; @@ -351,6 +364,11 @@ static int amdgpu_discovery_init(struct amdgpu_de=
vice *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; goto out;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // init sysfs for ip_discovery<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D sysfs_create_file(&amp;ade=
v-&gt;dev-&gt;kobj, &amp;dev_attr_ip_discovery_text.attr);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;Could not create amdgpu device =
attr\n&quot;);<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;<br>
&gt;&nbsp; out:<br>
&gt; @@ -363,7 +381,11 @@ static int amdgpu_discovery_init(struct amdgpu_de=
vice *adev)<br>
&gt;&nbsp; void amdgpu_discovery_fini(struct amdgpu_device *adev)<br>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(adev-&gt;mman.di=
scovery_bin);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(adev-&gt;ip_discovery_text=
);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sysfs_remove_file(&amp;adev-&gt;=
dev-&gt;kobj, &amp;dev_attr_ip_discovery_text.attr);<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;mman.discover=
y_bin =3D NULL;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_discovery_text =3D N=
ULL;<br>
&gt;&nbsp; }<br>
&gt;<br>
&gt;&nbsp; static int amdgpu_discovery_validate_ip(const struct ip *ip)<br>
&gt; @@ -382,6 +404,20 @@ static int amdgpu_discovery_validate_ip(const str=
uct ip *ip)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp; }<br>
&gt;<br>
&gt; +static int add_string(char **dst, unsigned *size, char *src)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (strlen(src) + strlen(*dst) &=
gt;=3D *size) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; void *tmp =3D krealloc(*dst, *size + 4096, GFP_KERNEL);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (!tmp) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -1;<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; *dst =3D tmp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; *size =3D *size + 4096;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; strcat(*dst, src);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt;&nbsp; int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)<b=
r>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct binary_header *=
bhdr;<br>
&gt; @@ -396,6 +432,8 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_d=
evice *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int hw_ip;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, j, k;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned txt_size =3D 4096;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *linebuf;<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_discovery=
_init(adev);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {<br>
&gt; @@ -410,6 +448,15 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_=
device *adev)<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEBUG(&quot;number=
 of dies: %d\n&quot;, num_dies);<br>
&gt;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_discovery_text =3D k=
zalloc(txt_size, GFP_KERNEL);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; linebuf =3D kzalloc(4096, GFP_KE=
RNEL);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;ip_discovery_text =
|| !linebuf) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; DRM_ERROR(&quot;Out of memory\n&quot;);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; kfree(linebuf);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; kfree(adev-&gt;ip_discovery_text);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return -ENOMEM;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; n=
um_dies; i++) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; die_offset =3D le16_to_cpu(ihdr-&gt;die_info[i].d=
ie_offset);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; dhdr =3D (struct die_header *)(adev-&gt;mman.disc=
overy_bin + die_offset);<br>
&gt; @@ -419,6 +466,8 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_d=
evice *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; if (le16_to_cpu(dhdr-&gt;die_id) !=3D i) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; D=
RM_ERROR(&quot;invalid die id %d, expected %d\n&quot;,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; le16_to_cpu(dhdr-&gt;die_id), i);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(lineb=
uf);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(adev-=
&gt;ip_discovery_text);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r=
eturn -EINVAL;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;<br>
&gt; @@ -458,6 +507,19 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_=
device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; le16_to_cpu(ip-&gt;hw_id) =3D=3D SDMA3_HWID)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;sdma.num_instances+=
+;<br>
&gt;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; snprintf(li=
nebuf, 4096, &quot;%s{%d} v%d.%d.%d: &quot;,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hw_id_names[le16_to_cpu(ip=
-&gt;hw_id)],<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ip-&gt;number_instance,<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ip-&gt;major, ip-&gt;minor=
,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ip-&gt;revision);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (add_str=
ing(&amp;adev-&gt;ip_discovery_text, &amp;txt_size, linebuf)) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;Out of memory\n&quot;)=
;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(linebuf);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(adev-&gt;ip_discovery_text);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOMEM;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; f=
or (k =3D 0; k &lt; num_base_address; k++) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * convert the endianne=
ss of base addresses in place,<br>
&gt; @@ -465,6 +527,19 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_=
device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ip-&gt;base_address[k] =3D l=
e32_to_cpu(ip-&gt;base_address[k]);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEBUG(&quot;\t0x%08x\n&q=
uot;, ip-&gt;base_address[k]);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; snprintf(linebuf, 4096, &quot;%08lx &q=
uot;, (unsigned long)ip-&gt;base_address[k]);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (add_string(&amp;adev-&gt;ip_discov=
ery_text, &amp;txt_size, linebuf)) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; DRM_ERROR(&quot;Out of memory\n&quot;);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; kfree(linebuf);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; kfree(adev-&gt;ip_discovery_text);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; return -ENOMEM;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (add_str=
ing(&amp;adev-&gt;ip_discovery_text, &amp;txt_size, &quot;\n&quot;)) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;Out of memory\n&quot;)=
;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(linebuf);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(adev-&gt;ip_discovery_text);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOMEM;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }=
<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; f=
or (hw_ip =3D 0; hw_ip &lt; MAX_HWIP; hw_ip++) {<br>
&gt; @@ -491,7 +566,7 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_d=
evice *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i=
p_offset +=3D sizeof(*ip) + 4 * (ip-&gt;num_base_address - 1);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(linebuf);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp; }<br>
&gt;<br>
&gt; --<br>
&gt; 2.32.0<br>
&gt;<br>
</div>
</span></font></div>
</body>
</html>

--_000_DM6PR12MB3547A57A5019D763E35091E4F75F9DM6PR12MB3547namp_--
