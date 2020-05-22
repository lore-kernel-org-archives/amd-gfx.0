Return-Path: <SRS0=+s4F=7E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 858C7C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 06:06:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4794D2073B
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 06:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="QmqTrIBQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4794D2073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 065B36E2F0;
	Fri, 22 May 2020 06:06:19 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750077.outbound.protection.outlook.com [40.107.75.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FF906E2F0
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2020 06:06:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MFV0VMyWDr79mKlSt/LCvj6yUplAk/AzezE59lsde4l5BDav6q4QbK4YPYttSavg0vk51m1uO3/LVOH2oDEmansFIn+P0rVvIqiTurfZFEi3yFT5qIeDSyhN/bgbkXVHnjyAR6Uug6JxafR9DCeR+I5JvN0c5WZ/XIkVdWWjUbHOxGHD+We0ip0DJcE3zrbA8wAWu8I5vWYHRGEARXkxfQUgw9T++EsoHSVtNF5I8s/CzS7WEMuXECi983caG4MQWFk+Y0PnnE+ItLuhUITT+b9ZyLoJr03xU4mZgehTX11CU6zzNymXfFeCecG23YXvBMHwqK7hSToaY3rpzhRKfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8NwjUI5QLfeiGjIEkpQ1fn/vHUvQg4mUH9UX9so5ulc=;
 b=fqzs7aDMulncYop/LvIyY01sjOtDLXs9xKek4fv/ZeSqbbUDdtIwWemEzq4unM+6zQmR/l85SAMwuLkHimEo25LtiyjUYHl1mcLS9t/ID1fVkI9UHNK86PKKmKokGbabacd8P6Aiv3t2YFAiYe33T3peTFpKMGFgXa779ifCsQ2ivShaWH3KjGLFb3ywxhcp77nOVN1ObRPCXojl91vsVixaKn6ZxUSpC0qwi7qpsNNfV5Tsfe0cDf0lVKr9lz86wM2eKBWAd4JbHHFOB/8boK3MURN176/LW1c7m883fKIlJgNYflFL5TC50EEB+btCc1hIqWqowCrlreHs3gTq+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8NwjUI5QLfeiGjIEkpQ1fn/vHUvQg4mUH9UX9so5ulc=;
 b=QmqTrIBQdh5XT5MlT9RDL+fNROvrNbo7fNTVIqiUjXGHaddn6kYcvhRhobYGYxVAxkiDEQ1rmHQjRY9JhiFlKPPy9JHTZstIFjfhbhC+9cDOr9YYne4di7hXRQ4ocVsjT0WuppJteLgNqK6SqozYT1V3Ws5WNECIg0Qk8DjIWMA=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB2716.namprd12.prod.outlook.com (2603:10b6:5:49::25) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.31; Fri, 22 May 2020 06:06:16 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3000.022; Fri, 22 May 2020
 06:06:16 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx list
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/3] drm/amdgpu: move discovery gfx config fetching
Thread-Topic: [PATCH 1/3] drm/amdgpu: move discovery gfx config fetching
Thread-Index: AQHWKuca6YjMcWJif0C3Bz8XyhrLz6iynvOAgAEJPDA=
Date: Fri, 22 May 2020 06:06:16 +0000
Message-ID: <DM6PR12MB2619A8D79000000FD8A48210E4B40@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20200515183135.626855-1-alexander.deucher@amd.com>
 <CADnq5_P16h9KJ=gT3wfGU8Kg0XjrJVwZoFNqJC3U4G4_LNO37A@mail.gmail.com>
In-Reply-To: <CADnq5_P16h9KJ=gT3wfGU8Kg0XjrJVwZoFNqJC3U4G4_LNO37A@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=34ff09fe-9150-46df-8bc9-00005a160d6e;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-05-22T06:05:30Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e41739c7-9b74-41f0-71f3-08d7fe163d3c
x-ms-traffictypediagnostic: DM6PR12MB2716:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB271623757C618C4B03F649D6E4B40@DM6PR12MB2716.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 04111BAC64
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d02xYt8hSdhbgvsj6psjBPv8iZvZin22TUwHSTahQwg+Yd8YVx8AWIxuamSC0Xccl+lqnpgsu46uzV4n5toIQ64qvBvkJtsazL0iDy3JA1rnhqzlQ333DSVJRkelmSe4c9dnoG2V/HqFWl9cRhSxb8IKq1FRdZPPuzGdBa2nzxpjupdaTUmwUloaeOATaaDMzs6aTBd+hvrvk8lru/Y6b5HLGfYEnMB2OhczBv3cqPT8q2EzubbOJsCv5xiA3v0kiAH6NI2oIgqg1aYu08HesAzW1dSh8t/eZl2h6DV7Gd4X732B6w2G9uERlVBUt5TRRyFI/cCojaT2XO3NLjSL8mbw7aGIJAKK2nY6OHmF4beJi8ss8lkfqs9rIDLqj1je8stVZEDXeVGbLvuv/XF7rUH2pt3It42hKNjWQ8tDQmPi27VpNr4MW1Qwmxlr3IV6x6OO42XEH0L3lrhBPMj9U1/WILTHGhg8EHItZct8Iw4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(366004)(396003)(39860400002)(136003)(346002)(966005)(66446008)(71200400001)(5660300002)(55016002)(110136005)(86362001)(8676002)(33656002)(186003)(478600001)(52536014)(7696005)(26005)(9686003)(45080400002)(8936002)(316002)(53546011)(6506007)(4326008)(64756008)(66556008)(66946007)(66476007)(2906002)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: A9os2E607Me/BaLwOxUqTgOsdqh2wQx3qS/pKPjbJd4K3+Lzg5tSg2ZFskv7cZditraoFpkOyJwuCcVSn0Z5EN0CuLe3mwdJp7tXNSF+oXA7AUyLNENiqSOnaT2+VJzsBHclqssIhmbBdzeMllQeHL7OJ1Tbj78uhk0Z7cS365u2mI2utlQE+mB39e7v+226qwBAmh9ddw9ipBZurgUEHkuoodczj57xvJVugJoHDeXUW/Ha1HUi2/SLlD5FcRaW3c8/KRuwONuRX09Lj6RdqsizyIU21JwVSaoWELEoXwAgjcOzpio0XNevckBi6QdHLZsw1GauQ+G3++afIs7wwiSBisfsfTCr3WhoxJlEmTwkUB1qWMIb0706UefmQi6Uxm5GKtfrEfNUDLjjLq5ihY0TS1mxILFl0/Oh12mLVQj92phwx1UAGkCbGHrohdav2q6ZAZpSIgER7IlVc+8MIBCaVR6RqfkWJj6hefTql/+7dD3AL9/q0GggvMIJ3Hv0
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e41739c7-9b74-41f0-71f3-08d7fe163d3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2020 06:06:16.4402 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /RRFdY4Q2bHKnQ5Ac6TiEfvn6Tn8VGZJ9PdtPIH9UqPB+Gf8SyhA67rqyi31Slk9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2716
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Patch1, 2 are reviewed-by: Evan Quan <evan.quan@amd.com>
Patch3 is acked-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Thursday, May 21, 2020 10:16 PM
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: Re: [PATCH 1/3] drm/amdgpu: move discovery gfx config fetching

Ping on this series?  It fixes an ordering issue for raven2.

Alex

On Fri, May 15, 2020 at 2:31 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> Move it into the fw_info function since it's logically part of the
> same functionality.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index cc41e8f5ad14..bab1be7abdf0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1617,8 +1617,10 @@ static int amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)
>                         (const struct gpu_info_firmware_v1_0 *)(adev->firmware.gpu_info_fw->data +
>
> le32_to_cpu(hdr->header.ucode_array_offset_bytes));
>
> -               if (amdgpu_discovery && adev->asic_type >= CHIP_NAVI10)
> +               if (amdgpu_discovery && adev->asic_type >= CHIP_NAVI10) {
> +                       amdgpu_discovery_get_gfx_info(adev);
>                         goto parse_soc_bounding_box;
> +               }
>
>                 adev->gfx.config.max_shader_engines = le32_to_cpu(gpu_info_fw->gc_num_se);
>                 adev->gfx.config.max_cu_per_sh =
> le32_to_cpu(gpu_info_fw->gc_num_cu_per_sh);
> @@ -1768,9 +1770,6 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>         if (r)
>                 return r;
>
> -       if (amdgpu_discovery && adev->asic_type >= CHIP_NAVI10)
> -               amdgpu_discovery_get_gfx_info(adev);
> -
>         amdgpu_amdkfd_device_probe(adev);
>
>         if (amdgpu_sriov_vf(adev)) {
> --
> 2.25.4
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cevan.quan%40amd.com%7Cb692d163dea04a8d9f3208d7fd918cbd%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637256673921983400&amp;sdata=mkNxi6pmkJCpIWNmzHhdmMk6%2BcYR%2BAYJcwwCvoDhlqs%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
