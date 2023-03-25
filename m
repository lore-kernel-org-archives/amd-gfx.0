Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B36BC76195
	for <amd-gfx@archiver.kernel.org>; Sat, 25 Mar 2023 01:49:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CA0C10E04F;
	Sat, 25 Mar 2023 01:49:12 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B375710E04F
 for <amd-gfx@lists.freedesktop.org>; Sat, 25 Mar 2023 01:49:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h45CZxw1SqlEVGHnt73+Upq1AoS9ggFsS4Kf7cYWnlhQGMDvpx7qZllLcaQVx5Sx+PZIHMYdS9TdtXM0B6gbrJAOb6ZGXTkkqzKSDy5FHfWrRvZTLz+9sX83WIfOh1HQnnMVLOwE2Ue1LyldYzGcNA6/+RCdo3acZqipj7WFdHo2MwdtMWvKiF7vqThfTOH/4EV/QggvaNUd8JZRjEfekHCcvf/MwnGYs4mibGxii4VJIFnBpgXwpkwsLrHksqj2Plhwtm+mv5HZ4rzBRUb+HEjNOg/FME0Niw6COjdyFZ51ljVYWmL4LhyANij7HOtkaxkOc3IBGAy028VuWVT1xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l0P5MEsT6X4CxpLKwmx9KUc/HQo81iezY6n70KulWZU=;
 b=VYsT/uP8Aty5SAHNo6qdPT/8eptuk6H5wwXO5RlK7YEtWIHFkvccmKaIAxCqTQX+Rxw1zlfR74D4P1BBd7RXvYtkjZ6FsiffUblY7K8os09TW/jKTKm1wrIG0kOQ4/DFMawooD0+DHS8PiAubHZTMEyKEf0myjSdxt81t2MHac4hTS70kJz1fsYuN3+hwWcEtYK8qQgs9EG2jrEaj2vMMwcXTlRTE2fz1hTwXziraBHkJZaBVqrsU8hHBB45SG5aLgZBgO0rZ+OBzZiR8zHtHdyL38SU+9Ji1t98AiuTtc1xx9uAzHX6vrKp+0yb4Aq52wyINbYVhzgUtNcEyqmKrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l0P5MEsT6X4CxpLKwmx9KUc/HQo81iezY6n70KulWZU=;
 b=ttk6KvBlyo1aWc929M3bbASHKdFCQ9gCIWnuQSIkQQzENdEdaol7jmrE1TQEtmFJPcE7dmRKL/zZXh3nB51EL4mDhIpINwfCcFj6fEKP13CdX4z5FqWMYNhvpQVJFb4PAWf741oe6T1JuHVRHJubC+/Jc7+LaHJzEme/Ouo6X1g=
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by PH8PR12MB6721.namprd12.prod.outlook.com (2603:10b6:510:1cc::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Sat, 25 Mar
 2023 01:49:07 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::3e46:4948:b543:8dba]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::3e46:4948:b543:8dba%2]) with mapi id 15.20.6178.038; Sat, 25 Mar 2023
 01:49:06 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>, "Yang, WenYou"
 <WenYou.Yang@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>, "Pan, Xinhui"
 <Xinhui.Pan@amd.com>
Subject: Re: [v1,2/3] drm/amd/pm: send the SMT-enable message to pmfw
Thread-Topic: [v1,2/3] drm/amd/pm: send the SMT-enable message to pmfw
Thread-Index: AQHZXa66OdtB1ss/Fk6yY9ZnbS90G68IqPOAgACMjwCAAQE2gIAAhNtJ
Date: Sat, 25 Mar 2023 01:49:06 +0000
Message-ID: <BYAPR12MB461432D54AA86C2CDFBE838997859@BYAPR12MB4614.namprd12.prod.outlook.com>
References: <20230322054808.1555230-3-WenYou.Yang@amd.com>
 <2c8c7a2a-566d-22a7-dc9b-5e08fbaf726c@amd.com>
 <07785bf1-80a0-e6db-66a3-eca43c5e945d@amd.com>
 <fb4548f4-098a-c9ed-26ce-4c98d7219773@amd.com>
 <MN0PR12MB6101644046D01AC2C2A8ED1DE2849@MN0PR12MB6101.namprd12.prod.outlook.com>
In-Reply-To: <MN0PR12MB6101644046D01AC2C2A8ED1DE2849@MN0PR12MB6101.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-03-24T17:49:53.0000000Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4614:EE_|PH8PR12MB6721:EE_
x-ms-office365-filtering-correlation-id: b50a44dc-3de2-4cc8-3389-08db2cd31e62
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vfvvaFl1a9Qn2IhUBIj5aVRRj/tD4DsEiSpCLr+VPcW3t7jb5ynhHxmdS164sG/aYNErRNLXhWAoV+MFWvFEBg6uFMUuBaTySbIU5H6dJJrPB2RPrasIcPYdVz5laBMfUvTQWo8stqLlBJrEM1agQbjevifKCJdTHDwWSCFhQRvutsWxoZX6QER/yOnjM+r26COY62eauaCO5RjmvcOyBFXJmuWnyoLGMDOCG8tkRCJrtGzX+pIA2lX9HS7asn0opA2YDgsbxxpccfE6fdU96In47vCz6dXQr+c2sK3xS0rIR/EZyk1ZdEn7/zNc8OvujGDQBNu0zDGBFhB7pis0H6dtBg9ehk/75mX1+XL9iKrN5MgsbQg5gqLZUVa7Zn4lPK20BPPQgA9INH6La35IEKlFXtGoMwnBcK13jEIjbKnK4vK13p7ONbrbBE4K6cBCG4SR5LiMkngj1IKskcmXCTT8CBIK92IgQomYqtC6UavM9kETalwWGredUOijie2mO/g0nw/DZCQZqer8KZj6mLYRguHtEBcr9tcP0Mk9KhjqimNZl1gZg16SOZz17FHL1qhnqQKIwGoNBGzdoiMy2N2KVRER4GJDmPCUAiMs/j18bz/9iKO3xPeDrrdHH12oSFS2yPULIbI9gaoPNhgxqArUSQ+dDFNpG3SCx1jvEUg54Ayg1/WYmyibfdTIyGFXw1PespD/hRmKXPKns/nRqYLkiGTKhFN/7NPc1Q/TfGs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(366004)(346002)(396003)(39860400002)(376002)(451199021)(38100700002)(26005)(9686003)(53546011)(66446008)(8676002)(33656002)(38070700005)(52536014)(15650500001)(478600001)(54906003)(7696005)(2906002)(71200400001)(6506007)(6636002)(316002)(66476007)(66556008)(66946007)(86362001)(110136005)(76116006)(186003)(91956017)(55016003)(64756008)(921005)(5660300002)(122000001)(41300700001)(83380400001)(8936002)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pZYWTI3PZS9iegUznbIdiZJDJ1EIpA03XAXEil5dSAqD98iQ1SvQzRJ5R7z9?=
 =?us-ascii?Q?KCFQgmhRCN07rXa5xy6IAToREq9/M0bykVA7Cq8rSzSob+sEnVKMV/5fz3mB?=
 =?us-ascii?Q?uMwICnJz/iuHAdCH91cgkVtKsjQ37BiJheaV2huisp/nudxc8xVRUrIouMIH?=
 =?us-ascii?Q?zKSEaUWz9KUmZQh600tz7hiafFQ0P/GKA6a92fQFtb4aAZiWZVyxhmKGBzi7?=
 =?us-ascii?Q?/Qs7GsyhKoje6yFJqfqYRGp4JGjlFtb/l8g6TFt38CAShJXe419nKLj4EFjq?=
 =?us-ascii?Q?mP4fHLdJ7T0+iKP0NN/F/7/LSVk4HgIALug7noF0fJZT3WY+Ns2CtldnZ2wI?=
 =?us-ascii?Q?sQMCndEAFzU8MeBAUSxPb5wgeW6lEvsLl5FQL7zE3KSns52On2UN2vhiEp4s?=
 =?us-ascii?Q?KHVQthVvoWKjt5TjxK0fkf0pV5cCuwXvgV9Ay9fl1VRSSmvDpSbMt6TsAA3z?=
 =?us-ascii?Q?ZTCqAEBzyjlL5GmlvvCXGuXG4GcMhqwNpEfKh5kzyKaH5m2SYdoDVUcAUekS?=
 =?us-ascii?Q?dVcTOWTxccgnrWiFjovcVDNADzEux3Ks4MwNnj70l/bqUPGs6Ok1iev5FEcE?=
 =?us-ascii?Q?4BjrJ0g9Wa24Pj9scBvCE3kBgjgZ0D0oQdaSFxDO6579c0zqNDYHSLB48fUD?=
 =?us-ascii?Q?50ByO5o4VZG2XlNbXPoKwMceW7fMfWB3itpnC9DdiXSwMVGRgpX+7qveZHqh?=
 =?us-ascii?Q?Erju0+j5bBU5DexTCTW+3dT+5vAWfwi1c596RtU7DiVzJbxmk3rQ2AgS54MM?=
 =?us-ascii?Q?k6dt9VK/3mi8PBkjENfSmwFViSXY8ytJ4pNmb1N3falgcgsy8yUtG718fTmd?=
 =?us-ascii?Q?mbNrHDM9L44Qpm3mhkq1F1svrB0KTZGx4d9/wILecAkzMvcUIk4svqzE6B30?=
 =?us-ascii?Q?o75Cy8+YxShKVks8tZBXNRpBBmGBS7H9VNu44ILkXkbvhco3F2IGSleVQ1Q0?=
 =?us-ascii?Q?hgU2JgqdWHZ589mY/h0sVczGxtzntkdAtiqHEqzpOTOauLbCw1FOvKbYBxza?=
 =?us-ascii?Q?qPkVmgvZ2E0XSPhiEyXcmzjg6m3oaXcYXkCUOtg8Yowd660d57yoU8Sm5p72?=
 =?us-ascii?Q?kGWmdCXO1B5tKrc0UCfZoX2mSKMnc0cwPTTXKymXM4hujJknGVUtvIGM7GXG?=
 =?us-ascii?Q?qAX0zS0ASd4/FD1XVXkmD0hp/+MVJ7a5uBuRGbvsIgj/wn7xnZYAE7mfC66N?=
 =?us-ascii?Q?8ezM3NN1ho6RkNE8a3E4KluaW2KhCo+f919/5pz+KITFH108LYjZz74dXUVC?=
 =?us-ascii?Q?OS+y6tZc8bR1qID/WFfvxWBitEA7j4GXzh66YMB8s/Oxp9dFQjQBQ1kCz4AG?=
 =?us-ascii?Q?qfmpwAJgE+bW4YjzbvqMW/F00Q/RrhfbtTAY6qmmUwKKkdFt72oTlFWGdmZn?=
 =?us-ascii?Q?E0z7jO0WX/RP48OUfLw1utT/S79soKZjPIeFHAnAF3ttdmARALrDQYVcMu/8?=
 =?us-ascii?Q?jow4VSuOT1QOFagHYtp5kU9LF3NGrRi/9wOchN/DNMWm3vYDSX12hUPwcs/3?=
 =?us-ascii?Q?9s4vtkHC/K/+RkRHqOn/u26f6YKNv2YB2ihHCzZUOU55kwYZGNeTwNyFDJqE?=
 =?us-ascii?Q?Zrp7Rdc0TdCGlnFnx7rvcNcEdvf4bmAOgyCpHjpl?=
Content-Type: multipart/alternative;
 boundary="_000_BYAPR12MB461432D54AA86C2CDFBE838997859BYAPR12MB4614namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b50a44dc-3de2-4cc8-3389-08db2cd31e62
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2023 01:49:06.2374 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /RoibD3KAlcFQZFB2wpcQPN1Xf54/41Y2k/IyZRcSl7CrW38eiE4cchTmZ0Nw7bx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6721
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
Cc: "Li, Ying" <YING.LI@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Liang, 
 Richard qi" <Richardqi.Liang@amd.com>, "Liu, Kun" <Kun.Liu2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BYAPR12MB461432D54AA86C2CDFBE838997859BYAPR12MB4614namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]



The notifier block is embedded in smu context of a device. If there are 4 d=
evices and 3 of them are interested, they register using the notifier block=
 within their smu context. Notifier is called in a chain and when received =
they use the container_of to get the smu context and communicate with the r=
espective device's FW on the actions to do.

BTW, I don't know why dGPU PMFW would be interested in SMT change. On AMD A=
PU + dGPU we already have things like smartshift and it will take care if c=
ommunicated to APU alone.

Thanks,
Lijo
________________________________
From: Limonciello, Mario <Mario.Limonciello@amd.com>
Sent: Friday, March 24, 2023 11:19:55 PM
To: Lazar, Lijo <Lijo.Lazar@amd.com>; Yang, WenYou <WenYou.Yang@amd.com>; D=
eucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian=
.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>
Cc: Li, Ying <YING.LI@amd.com>; Liu, Kun <Kun.Liu2@amd.com>; Liang, Richard=
 qi <Richardqi.Liang@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@lists=
.freedesktop.org>
Subject: RE: [v1,2/3] drm/amd/pm: send the SMT-enable message to pmfw

[AMD Official Use Only - General]



> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Thursday, March 23, 2023 21:29
> To: Limonciello, Mario <Mario.Limonciello@amd.com>; Yang, WenYou
> <WenYou.Yang@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>
> Cc: Li, Ying <YING.LI@amd.com>; Liu, Kun <Kun.Liu2@amd.com>; Liang,
> Richard qi <Richardqi.Liang@amd.com>; amd-gfx@lists.freedesktop.org
> Subject: Re: [v1,2/3] drm/amd/pm: send the SMT-enable message to pmfw
>
>
>
> On 3/23/2023 11:36 PM, Limonciello, Mario wrote:
> > On 3/23/2023 12:41, Limonciello, Mario wrote:
> >> On 3/22/2023 00:48, Wenyou Yang wrote:
> >>> When the CPU SMT status change in the fly, sent the SMT-enable
> >>> message to pmfw to notify it that the SMT status changed.
> >>>
> >>> Signed-off-by: Wenyou Yang <WenYou.Yang@amd.com>
> >>> ---
> >>>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 41
> +++++++++++++++++++
> >>>   drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  5 +++
> >>>   2 files changed, 46 insertions(+)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> >>> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> >>> index b5d64749990e..5cd85a9d149d 100644
> >>> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> >>> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> >>> @@ -22,6 +22,7 @@
> >>>   #define SWSMU_CODE_LAYER_L1
> >>> +#include <linux/cpu.h>
> >>>   #include <linux/firmware.h>
> >>>   #include <linux/pci.h>
> >>> @@ -69,6 +70,14 @@ static int smu_set_fan_speed_rpm(void *handle,
> >>> uint32_t speed);
> >>>   static int smu_set_gfx_cgpg(struct smu_context *smu, bool enabled);
> >>>   static int smu_set_mp1_state(void *handle, enum pp_mp1_state
> >>> mp1_state);
> >>> +static int smt_notifier_callback(struct notifier_block *nb, unsigned
> >>> long action, void *data);
> >>> +
> >>> +extern struct raw_notifier_head smt_notifier_head;
> >>> +
> >>> +static struct notifier_block smt_notifier =3D {
> >>> +    .notifier_call =3D smt_notifier_callback,
> >>> +};
> >>> +
> >>>   static int smu_sys_get_pp_feature_mask(void *handle,
> >>>                          char *buf)
> >>>   {
> >>> @@ -625,6 +634,8 @@ static int smu_set_funcs(struct amdgpu_device
> *adev)
> >>>       return 0;
> >>>   }
> >>> +static struct smu_context *current_smu;
> >>> +
> >>>   static int smu_early_init(void *handle)
> >>>   {
> >>>       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> >>> @@ -645,6 +656,7 @@ static int smu_early_init(void *handle)
> >>>       mutex_init(&smu->message_lock);
> >>>       adev->powerplay.pp_handle =3D smu;
> >>> +    current_smu =3D smu;
> >
> > Although this series is intended for the Van Gogh case right now, I
> > dont't think this would scale well for multiple GPUs in a system.
> >
> > I think that instead you may want to move the notifier callback to be a
> > level "higher" in amdgpu.  Perhaps amdgpu_device.c?  Then when that
> > notifier call is received you'll want to walk through the PCI device
> > space to find any GPUs that are bound with AMDGPU a series of
> > wrappers/calls that end up calling smu_set_cpu_smt_enable with the
> > approriate arguments.
> >
>
> This is not required when the notifier is registered only within Vangogh
> ppt function. Then follow Evan's suggestion of keeping the notifier
> block inside smu. From the notifier block, it can find the smu block and
> then call cpu_smt_enable/disable. That way notifier callback comes only
> once even with multiple dGPUs + Vangogh and processed for the
> corresponding smu.
>
> This notifier doesn't need to be registered for platforms only with
> dGPUs or APUs which don't need this.

They don't right now, but I was thinking how this could scale to other
APUs or dGPUs if they are interested in adding support for this message
too.

>
> Thanks,
> Lijo
>
> >
> >>>       adev->powerplay.pp_funcs =3D &swsmu_pm_funcs;
> >>>       r =3D smu_set_funcs(adev);
> >>> @@ -1105,6 +1117,8 @@ static int smu_sw_init(void *handle)
> >>>       if (!smu->ppt_funcs->get_fan_control_mode)
> >>>           smu->adev->pm.no_fan =3D true;
> >>> +    raw_notifier_chain_register(&smt_notifier_head, &smt_notifier);
> >>> +
> >>>       return 0;
> >>>   }
> >>> @@ -1122,6 +1136,8 @@ static int smu_sw_fini(void *handle)
> >>>       smu_fini_microcode(smu);
> >>> +    raw_notifier_chain_unregister(&smt_notifier_head, &smt_notifier)=
;
> >>> +
> >>>       return 0;
> >>>   }
> >>> @@ -3241,3 +3257,28 @@ int smu_send_hbm_bad_channel_flag(struct
> >>> smu_context *smu, uint32_t size)
> >>>       return ret;
> >>>   }
> >>> +
> >>> +static int smu_set_cpu_smt_enable(struct smu_context *smu, bool
> enable)
> >>> +{
> >>> +    int ret =3D -EINVAL;
> >>> +
> >>> +    if (smu->ppt_funcs && smu->ppt_funcs->set_cpu_smt_enable)
> >>> +        ret =3D smu->ppt_funcs->set_cpu_smt_enable(smu, enable);
> >>> +
> >>> +    return ret;
> >>> +}
> >>> +
> >>> +static int smt_notifier_callback(struct notifier_block *nb,
> >>> +                 unsigned long action, void *data)
> >>> +{
> >>> +    struct smu_context *smu =3D current_smu;
> >>> +    int ret =3D NOTIFY_OK;
> >>
> >> This initialization is pointless, it's clobbered in the next line.
> >>
> >>> +
> >>> +    ret =3D (action =3D=3D SMT_ENABLED) ?
> >>> +                smu_set_cpu_smt_enable(smu, true) :
> >>> +                smu_set_cpu_smt_enable(smu, false);
> >>
> >> How about this instead, it should be more readable:
> >>
> >>      ret =3D smu_set_cpu_smt_enable(smu, action =3D=3D SMT_ENABLED);
> >>
> >>> +    if (ret)
> >>> +        ret =3D NOTIFY_BAD;
> >>> +
> >>> +    return ret;
> >>
> >> How about instead:
> >>
> >>      dev_dbg(adev->dev, "failed to %sable SMT: %d\n", action =3D=3D
> >> SMT_ENABLED ? "en" : "dis", ret);
> >>
> >>      return ret ? NOTIFY_BAD : NOTIFY_OK;
> >>
> >>> +}
> >>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> >>> b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> >>> index 09469c750a96..7c6594bba796 100644
> >>> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> >>> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> >>> @@ -1354,6 +1354,11 @@ struct pptable_funcs {
> >>>        * @init_pptable_microcode: Prepare the pptable microcode to
> >>> upload via PSP
> >>>        */
> >>>       int (*init_pptable_microcode)(struct smu_context *smu);
> >>> +
> >>> +    /**
> >>> +     * @set_cpu_smt_enable: Set the CPU SMT status
> >>> +     */
> >>> +    int (*set_cpu_smt_enable)(struct smu_context *smu, bool enable);
> >>>   };
> >>>   typedef enum {
> >>
> >

--_000_BYAPR12MB461432D54AA86C2CDFBE838997859BYAPR12MB4614namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div style=3D""><br>
</div>
<div id=3D"ms-outlook-mobile-signature" dir=3D"auto">
<div dir=3D"auto"><br>
<div dir=3D"auto" style=3D"font-size: medium; color: rgb(0, 0, 0);">The not=
ifier block is embedded in smu context of a device. If there are 4 devices =
and 3 of them are interested, they register using the notifier block within=
 their smu context. Notifier is called
 in a chain and when received they use the container_of to get the smu cont=
ext and communicate with the respective device's FW on the actions to do.</=
div>
<div dir=3D"auto" style=3D"font-size: medium; color: rgb(0, 0, 0);"><br>
</div>
<div dir=3D"auto" style=3D"font-size: medium; color: rgb(0, 0, 0);">BTW, I =
don't know why dGPU PMFW would be interested in SMT change. On AMD APU + dG=
PU we already have things like smartshift and it will take care if communic=
ated to APU alone.<br>
</div>
<div dir=3D"auto" style=3D"font-size: medium; color: rgb(0, 0, 0);"><br>
</div>
</div>
Thanks,<br>
Lijo</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Limonciello, Mario &l=
t;Mario.Limonciello@amd.com&gt;<br>
<b>Sent:</b> Friday, March 24, 2023 11:19:55 PM<br>
<b>To:</b> Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;; Yang, WenYou &lt;WenYou.=
Yang@amd.com&gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Koe=
nig, Christian &lt;Christian.Koenig@amd.com&gt;; Pan, Xinhui &lt;Xinhui.Pan=
@amd.com&gt;<br>
<b>Cc:</b> Li, Ying &lt;YING.LI@amd.com&gt;; Liu, Kun &lt;Kun.Liu2@amd.com&=
gt;; Liang, Richard qi &lt;Richardqi.Liang@amd.com&gt;; amd-gfx@lists.freed=
esktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> RE: [v1,2/3] drm/amd/pm: send the SMT-enable message to pmf=
w</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">[AMD Official Use Only - General]<br>
<br>
<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;<br>
&gt; Sent: Thursday, March 23, 2023 21:29<br>
&gt; To: Limonciello, Mario &lt;Mario.Limonciello@amd.com&gt;; Yang, WenYou=
<br>
&gt; &lt;WenYou.Yang@amd.com&gt;; Deucher, Alexander<br>
&gt; &lt;Alexander.Deucher@amd.com&gt;; Koenig, Christian<br>
&gt; &lt;Christian.Koenig@amd.com&gt;; Pan, Xinhui &lt;Xinhui.Pan@amd.com&g=
t;<br>
&gt; Cc: Li, Ying &lt;YING.LI@amd.com&gt;; Liu, Kun &lt;Kun.Liu2@amd.com&gt=
;; Liang,<br>
&gt; Richard qi &lt;Richardqi.Liang@amd.com&gt;; amd-gfx@lists.freedesktop.=
org<br>
&gt; Subject: Re: [v1,2/3] drm/amd/pm: send the SMT-enable message to pmfw<=
br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; On 3/23/2023 11:36 PM, Limonciello, Mario wrote:<br>
&gt; &gt; On 3/23/2023 12:41, Limonciello, Mario wrote:<br>
&gt; &gt;&gt; On 3/22/2023 00:48, Wenyou Yang wrote:<br>
&gt; &gt;&gt;&gt; When the CPU SMT status change in the fly, sent the SMT-e=
nable<br>
&gt; &gt;&gt;&gt; message to pmfw to notify it that the SMT status changed.=
<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; Signed-off-by: Wenyou Yang &lt;WenYou.Yang@amd.com&gt;<br=
>
&gt; &gt;&gt;&gt; ---<br>
&gt; &gt;&gt;&gt; &nbsp; drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c&nbsp;&nb=
sp;&nbsp;&nbsp; | 41<br>
&gt; +++++++++++++++++++<br>
&gt; &gt;&gt;&gt; &nbsp; drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |&nb=
sp; 5 +++<br>
&gt; &gt;&gt;&gt; &nbsp; 2 files changed, 46 insertions(+)<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br=
>
&gt; &gt;&gt;&gt; b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
&gt; &gt;&gt;&gt; index b5d64749990e..5cd85a9d149d 100644<br>
&gt; &gt;&gt;&gt; --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
&gt; &gt;&gt;&gt; +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
&gt; &gt;&gt;&gt; @@ -22,6 +22,7 @@<br>
&gt; &gt;&gt;&gt; &nbsp; #define SWSMU_CODE_LAYER_L1<br>
&gt; &gt;&gt;&gt; +#include &lt;linux/cpu.h&gt;<br>
&gt; &gt;&gt;&gt; &nbsp; #include &lt;linux/firmware.h&gt;<br>
&gt; &gt;&gt;&gt; &nbsp; #include &lt;linux/pci.h&gt;<br>
&gt; &gt;&gt;&gt; @@ -69,6 +70,14 @@ static int smu_set_fan_speed_rpm(void =
*handle,<br>
&gt; &gt;&gt;&gt; uint32_t speed);<br>
&gt; &gt;&gt;&gt; &nbsp; static int smu_set_gfx_cgpg(struct smu_context *sm=
u, bool enabled);<br>
&gt; &gt;&gt;&gt; &nbsp; static int smu_set_mp1_state(void *handle, enum pp=
_mp1_state<br>
&gt; &gt;&gt;&gt; mp1_state);<br>
&gt; &gt;&gt;&gt; +static int smt_notifier_callback(struct notifier_block *=
nb, unsigned<br>
&gt; &gt;&gt;&gt; long action, void *data);<br>
&gt; &gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt; +extern struct raw_notifier_head smt_notifier_head;<br>
&gt; &gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt; +static struct notifier_block smt_notifier =3D {<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; .notifier_call =3D smt_notifier_callb=
ack,<br>
&gt; &gt;&gt;&gt; +};<br>
&gt; &gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt; &nbsp; static int smu_sys_get_pp_feature_mask(void *handl=
e,<br>
&gt; &gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; char *buf)<br>
&gt; &gt;&gt;&gt; &nbsp; {<br>
&gt; &gt;&gt;&gt; @@ -625,6 +634,8 @@ static int smu_set_funcs(struct amdgp=
u_device<br>
&gt; *adev)<br>
&gt; &gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &gt;&gt;&gt; &nbsp; }<br>
&gt; &gt;&gt;&gt; +static struct smu_context *current_smu;<br>
&gt; &gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt; &nbsp; static int smu_early_init(void *handle)<br>
&gt; &gt;&gt;&gt; &nbsp; {<br>
&gt; &gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D (struct amdgpu_device *)handle;<br>
&gt; &gt;&gt;&gt; @@ -645,6 +656,7 @@ static int smu_early_init(void *handl=
e)<br>
&gt; &gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;smu-&gt;me=
ssage_lock);<br>
&gt; &gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;powerplay.pp_hand=
le =3D smu;<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; current_smu =3D smu;<br>
&gt; &gt;<br>
&gt; &gt; Although this series is intended for the Van Gogh case right now,=
 I<br>
&gt; &gt; dont't think this would scale well for multiple GPUs in a system.=
<br>
&gt; &gt;<br>
&gt; &gt; I think that instead you may want to move the notifier callback t=
o be a<br>
&gt; &gt; level &quot;higher&quot; in amdgpu.&nbsp; Perhaps amdgpu_device.c=
?&nbsp; Then when that<br>
&gt; &gt; notifier call is received you'll want to walk through the PCI dev=
ice<br>
&gt; &gt; space to find any GPUs that are bound with AMDGPU a series of<br>
&gt; &gt; wrappers/calls that end up calling smu_set_cpu_smt_enable with th=
e<br>
&gt; &gt; approriate arguments.<br>
&gt; &gt;<br>
&gt; <br>
&gt; This is not required when the notifier is registered only within Vango=
gh<br>
&gt; ppt function. Then follow Evan's suggestion of keeping the notifier<br=
>
&gt; block inside smu. From the notifier block, it can find the smu block a=
nd<br>
&gt; then call cpu_smt_enable/disable. That way notifier callback comes onl=
y<br>
&gt; once even with multiple dGPUs + Vangogh and processed for the<br>
&gt; corresponding smu.<br>
&gt; <br>
&gt; This notifier doesn't need to be registered for platforms only with<br=
>
&gt; dGPUs or APUs which don't need this.<br>
<br>
They don't right now, but I was thinking how this could scale to other<br>
APUs or dGPUs if they are interested in adding support for this message<br>
too.<br>
<br>
&gt; <br>
&gt; Thanks,<br>
&gt; Lijo<br>
&gt; <br>
&gt; &gt;<br>
&gt; &gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;powerplay.pp_func=
s =3D &amp;swsmu_pm_funcs;<br>
&gt; &gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D smu_set_funcs(adev);=
<br>
&gt; &gt;&gt;&gt; @@ -1105,6 +1117,8 @@ static int smu_sw_init(void *handle=
)<br>
&gt; &gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;ppt_funcs-&gt=
;get_fan_control_mode)<br>
&gt; &gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sm=
u-&gt;adev-&gt;pm.no_fan =3D true;<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; raw_notifier_chain_register(&amp;smt_=
notifier_head, &amp;smt_notifier);<br>
&gt; &gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &gt;&gt;&gt; &nbsp; }<br>
&gt; &gt;&gt;&gt; @@ -1122,6 +1136,8 @@ static int smu_sw_fini(void *handle=
)<br>
&gt; &gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_fini_microcode(smu);<b=
r>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; raw_notifier_chain_unregister(&amp;sm=
t_notifier_head, &amp;smt_notifier);<br>
&gt; &gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &gt;&gt;&gt; &nbsp; }<br>
&gt; &gt;&gt;&gt; @@ -3241,3 +3257,28 @@ int smu_send_hbm_bad_channel_flag(=
struct<br>
&gt; &gt;&gt;&gt; smu_context *smu, uint32_t size)<br>
&gt; &gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; &gt;&gt;&gt; &nbsp; }<br>
&gt; &gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt; +static int smu_set_cpu_smt_enable(struct smu_context *sm=
u, bool<br>
&gt; enable)<br>
&gt; &gt;&gt;&gt; +{<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; int ret =3D -EINVAL;<br>
&gt; &gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; if (smu-&gt;ppt_funcs &amp;&amp; smu-=
&gt;ppt_funcs-&gt;set_cpu_smt_enable)<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu-&=
gt;ppt_funcs-&gt;set_cpu_smt_enable(smu, enable);<br>
&gt; &gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; &gt;&gt;&gt; +}<br>
&gt; &gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt; +static int smt_notifier_callback(struct notifier_block *=
nb,<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long action, void *data)<=
br>
&gt; &gt;&gt;&gt; +{<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; struct smu_context *smu =3D current_s=
mu;<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; int ret =3D NOTIFY_OK;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; This initialization is pointless, it's clobbered in the next =
line.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; ret =3D (action =3D=3D SMT_ENABLED) ?=
<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_set_cpu_smt_enable(smu, true) :<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_set_cpu_smt_enable(smu, false);<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; How about this instead, it should be more readable:<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ret =3D smu_set_cpu_smt_enable(=
smu, action =3D=3D SMT_ENABLED);<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D NOTIF=
Y_BAD;<br>
&gt; &gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; How about instead:<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;dev_dbg(adev-&gt;dev, &quot;fai=
led to %sable SMT: %d\n&quot;, action =3D=3D<br>
&gt; &gt;&gt; SMT_ENABLED ? &quot;en&quot; : &quot;dis&quot;, ret);<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return ret ? NOTIFY_BAD : NOTIF=
Y_OK;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;&gt; +}<br>
&gt; &gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.=
h<br>
&gt; &gt;&gt;&gt; b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h<br>
&gt; &gt;&gt;&gt; index 09469c750a96..7c6594bba796 100644<br>
&gt; &gt;&gt;&gt; --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h<br>
&gt; &gt;&gt;&gt; +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h<br>
&gt; &gt;&gt;&gt; @@ -1354,6 +1354,11 @@ struct pptable_funcs {<br>
&gt; &gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * @init_pptable_micr=
ocode: Prepare the pptable microcode to<br>
&gt; &gt;&gt;&gt; upload via PSP<br>
&gt; &gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; &gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*init_pptable_microco=
de)(struct smu_context *smu);<br>
&gt; &gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; /**<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; * @set_cpu_smt_enable: Set the =
CPU SMT status<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; int (*set_cpu_smt_enable)(struct smu_=
context *smu, bool enable);<br>
&gt; &gt;&gt;&gt; &nbsp; };<br>
&gt; &gt;&gt;&gt; &nbsp; typedef enum {<br>
&gt; &gt;&gt;<br>
&gt; &gt;<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BYAPR12MB461432D54AA86C2CDFBE838997859BYAPR12MB4614namp_--
