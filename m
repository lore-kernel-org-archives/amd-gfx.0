Return-Path: <SRS0=N7Ef=ON=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B79EC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Sep 2021 13:04:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49E086103D
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Sep 2021 13:04:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 49E086103D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2DEC6E094;
	Thu, 23 Sep 2021 13:04:12 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2068.outbound.protection.outlook.com [40.107.102.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 466356E094
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Sep 2021 13:04:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FVLWE/P0W+G7PR38YYQ4sBpEWnmroJaqtthTiW7zkBBTuVdnSthrQruY2+KfGppYdYuv81pteWCN0QIwc1iOqY7CUw7WhIxb7ggofEuc9VkUWN4NTTzYS5xFAZbEGDpLv9DUmFRirm2R9UXY2REn4yC5RKtyfmrunbl3L6ZQFsFsEMDXVF6enWdeCTfG6n5Rr35zRMxOLKA7x9SBZnlQBhd/kfd4VpS3CGGdA2uLB9TwZk67Yl6ArsRAtpvUvBQFhC2GXpH9/Z/xM8ddstp+0JJdwgWDKQRMS7WRtK2m7PaDzO+NRiUACKOzkCx5r4YOvmR+3Ns86fhxx/5VAhKqrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=c1n6bujcpd4vpOh1BwSaC8Rfkg8pjiL+UNyVaz8JU80=;
 b=QIZVsP5PN9gfF+vHAq/5aZWKypDZSaJuCe/0sZ7eiydCzBPo+/igsEdu14GnEisGyi+DKyXgVx0O4wXlGD02dKYwNJLnvXYm4Yk2RxQkL5HQLmquELN/PJpefUA4eY26gjGnYIyXpIqVSfkXWiY2xrshQec6XX2hk4bu3T3hUKCVJpYbld/OSO9DONDyFFfp9WTyXEZJsCop81/FJlCCkZ5lSKQHl+xjTlUSHIpV9Qb5qPhOM5C7wKPvQSPBJhnZlVCyY5UPyfFDa97YMGbLWLehu+blw9o92wVknmvQkfbuhfyvXo6zZy3vJ6hSc9LOLCywvXDQkzFMcWivCB+k5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c1n6bujcpd4vpOh1BwSaC8Rfkg8pjiL+UNyVaz8JU80=;
 b=WrbmISCZaLksQBuCoIWPHh5Pry97BOiq8G51SDu6CBnxn3tT9Bj/Tj+e9eH3i0mJqa9KS15lg4IQNEv41VLGAQEqU3fSNIUhhrKD2z3wycq6Nv57Ax4byg2bym4yi9P+GZcNViyo2bJfyClmRXfo3SpB3WcBgahR0+yo2lytEZs=
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM5PR12MB1660.namprd12.prod.outlook.com (2603:10b6:4:9::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.15; Thu, 23 Sep 2021 13:04:09 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::5879:5961:8a30:6a57]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::5879:5961:8a30:6a57%7]) with mapi id 15.20.4544.015; Thu, 23 Sep 2021
 13:04:09 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: amd-gfx list <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Wang, 
 Yang(Kevin)" <KevinYang.Wang@amd.com>, "Feng, Kenneth"
 <Kenneth.Feng@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Update intermediate power state for SI
Thread-Topic: [PATCH] drm/amd/pm: Update intermediate power state for SI
Thread-Index: AQHXsDOxnm/Tc5YhgU2L0KDaBk7jGKuxkuuAgAAAhAA=
Date: Thu, 23 Sep 2021 13:04:09 +0000
Message-ID: <DM6PR12MB39301B88CEF191051CE6028397A39@DM6PR12MB3930.namprd12.prod.outlook.com>
References: <20210923042937.16385-1-lijo.lazar@amd.com>
 <CADnq5_NBP4ZGJ+gzDuWoiTMu8iD1yQ8N--QxGDzmb6-C82aJ2g@mail.gmail.com>
In-Reply-To: <CADnq5_NBP4ZGJ+gzDuWoiTMu8iD1yQ8N--QxGDzmb6-C82aJ2g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-09-23T13:04:04Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=6fd9571e-d2b3-41e2-82a0-b800b2ee567f;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4a980db7-6408-4f73-70b8-08d97e92a1b5
x-ms-traffictypediagnostic: DM5PR12MB1660:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1660CD38C49BC5CE7AD2DA8A97A39@DM5PR12MB1660.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4/ep0RgFGXF6LKXUtXiCUqvi3CgtDWaDbMMNYVx42z9SeRrej7Myev++X0f2D4Z5pqdqRCd6f45BSor16wqXINyrxpTL7iOvv6q5vbB3R70xKEtW0yvnywABArs7ffIsxlRz/jDq2hIqtHjO/W9eyNWP8EsD9lz0cq6cw+Gtdw6tvAozdcpBrM7130EU8Y4JwMOo667dpfXl503cFh/Ypf679CC1tuMJRX14YTA38rYZfbVUxqFeGvKaNy2UjOSGb08HznW+76a8GrMQv3uqjsTggkXI0In5yN4S0axAJji2Ebx/MaaE51aBp1TKDZg9EDnaSW78BAMWjG/rgZFT8R+5kMIMdxdFqumxUXZDBPzyQ3GvcGDZwI91n7eJaCEwxVHJM+BfTr3iqNLk//ff5v3wM6FLY9izou7FrPFXXnVPvCjsIFgmL5X9YVI6ubeKna8jv0rcb6eGu7iIOU1dGcTvsSwa/DB8jqtb4k7hL1ZtUstQ/uxU4qyVL9q+NTc95y7LrCpsHqxF0dg4MMZjkZecx8hrMdpATlFtm3J4uuZ05sKW5S/ijOH+qYKxBT5WJbCDcE9NNngwttI9JOEAtpd/bMyYhXYWt5BaUAjA6vOc/LaWsVLqAke3UHvViL4kIrI00k2uOH4x+CwfPOxYLy3uyaxk5GNhj/MAcNv9nL1Eb0K676qz0oIWMLHunS12eT3HGHDm+kQpv7ETHuuNZmQ0vVLhs6WvD22TT2KkduoZjTRfYs5BRPnR1UvSdQKmhURM15vGjCGqou0eUYbxgSn6rH2e0tlaPkd+GBQaCwY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38100700002)(55016002)(122000001)(52536014)(33656002)(508600001)(66446008)(64756008)(66556008)(66476007)(76116006)(7696005)(66946007)(45080400002)(15650500001)(54906003)(316002)(5660300002)(86362001)(6506007)(53546011)(4326008)(8936002)(71200400001)(9686003)(2906002)(26005)(186003)(8676002)(83380400001)(6916009)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?o3YqmOt4OtfpGboRmnH7klTBYTQBsUA/1f3n0BZ/h5OMZ0nGYqpX3edfhmx7?=
 =?us-ascii?Q?XUQ4WOmLml4zIHRVt0sfF17zB5VbkA18FF7QLqYlJViOfLoblmw3ZV19Dw6G?=
 =?us-ascii?Q?qsvhHQ8lVErLcdMvP8HZDzW+K5zu5eCU7Hb7r3hX2twFkReWse7LCSNPdK1E?=
 =?us-ascii?Q?6sC15HACOuYotWHswokJyHrpb+xfnKMUdKuJLa7+Iv0imyNnibNz4TNeWAly?=
 =?us-ascii?Q?FlwLsS1ZO1k76gSetgc4euxj25jO3vY3ds2bi6iBlsIDMvl+HdMquF7myzAj?=
 =?us-ascii?Q?hvCyCOIiryCRCGF9qfFt7dpnyT4KyxAyP6ktuPhWnG1wrUgcxDNo146LWPtE?=
 =?us-ascii?Q?TyzwKpATnfjs3eYOlSRqqWyRRbd2ofn3T/UpiS6WWMq1b44Q4wR9Sa9BiAK4?=
 =?us-ascii?Q?BQJ5vKjWNs39AU5JkE+e7spXiKjxIIkzcBm9xEsSvFR1kGVtPKc8iwT3rtsQ?=
 =?us-ascii?Q?prG3nlL8QLryl7cqY2zYJpWU013SS3rjvFzUfyJnEyPtEO0xSlAMdjcAKGqo?=
 =?us-ascii?Q?y8E2zG5uoP+IcGVX9R2EmrYhG5/hV5AegCkaq8ByjlE6bNExwqE8iadbLPJb?=
 =?us-ascii?Q?rrM4JZGBR31Sk+tm0XglNGr+4adGVIL5fBvs77MFLhJE0jwUQe1EP3M4VjOq?=
 =?us-ascii?Q?qnGKvNnPGp7WAx1MpOVah5xKwgYGm2luJgjGbUrx8AZxIq3JHn+1QnC6JTxg?=
 =?us-ascii?Q?U5XrGAnatG+VHS1v6QPHzBRi0uAqBGu0iKMGoQASAUywtLh1okVazZOcAtlD?=
 =?us-ascii?Q?cNR0QEq3WIo8+0eMWxndC5a/oHfSEKrQbbA4+G5U/zGs+YOHR2TZMmyx0ahZ?=
 =?us-ascii?Q?fzNfJ5Or3NZ/ank9UUHYPdXgZSbXizPhRkStrwIme7zHrbq9h8RDSNqJg9el?=
 =?us-ascii?Q?4drhHjdZYmkqcdprXMdkNBSpFPHvxI42T+4Dk2z1pQrRbd1YDPvD5Fjis09z?=
 =?us-ascii?Q?HUPCTY4fhva3V6TmRjo8fmntVWvGocIP/zD0NhiiBR5z3lsJXOuBG+2Xzj9I?=
 =?us-ascii?Q?o8+OcmlWjvjZC7kL6yNV+802ODjFfkTAKIudnKlywLdu4qK1yvoHjddhypS0?=
 =?us-ascii?Q?HBhOxCgmiaGZphPSWVjQbqhtiWmD6LgHWK0IN6UKLKy0Hoyc2cJCPlXh7hua?=
 =?us-ascii?Q?mMv8FQl1sEfEjbOb2cSfuQx6Ocb/Dy8x2vcQCQoC48XFrEeepgQFJSQ5qtoQ?=
 =?us-ascii?Q?ESnqAgWIC7an3qeQNq23vMo+doZRy7krxYp6e95aFGr8gIV5vZFR8UTl9Amr?=
 =?us-ascii?Q?1s59yWRJNJoycnLfjQ1vTRg6ofxZSdS1HoRuMJXFWoGdOwPesGyBQNvOK/sY?=
 =?us-ascii?Q?LxK/q9F+Rtunadu0xrn8+4jw?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a980db7-6408-4f73-70b8-08d97e92a1b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2021 13:04:09.2433 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +lAuIkIg2krfKF3sAv5J6zU+FG84RaBHDu3H0JVrsikTXFTFRZU1rUGb8nM1+cgE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1660
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Hi Alex,

"Fixes" tag - I interpret it as fixes some broken logic in the earlier patc=
h. This one doesn't fix f9b7f3703ff9 ("drm/amdgpu/acpi: make ATPX/ATCS stru=
ctures global (v2)"). That patch's logic works well and is fine as it is.=20

May be add a reference or some more details in the comments?=20

Thanks,
Lijo

-----Original Message-----
From: Alex Deucher <alexdeucher@gmail.com>=20
Sent: Thursday, September 23, 2021 6:21 PM
To: Lazar, Lijo <Lijo.Lazar@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Deucher, Alexander <Alexa=
nder.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Wang, Yang(K=
evin) <KevinYang.Wang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Quan,=
 Evan <Evan.Quan@amd.com>
Subject: Re: [PATCH] drm/amd/pm: Update intermediate power state for SI

Acked-by: Alex Deucher <alexander.deucher@amd.com>
Fixes: f9b7f3703ff9 ("drm/amdgpu/acpi: make ATPX/ATCS structures global (v2=
)")

Thanks!

On Thu, Sep 23, 2021 at 12:30 AM Lijo Lazar <lijo.lazar@amd.com> wrote:
>
> Update the current state as boot state during dpm initialization.
> During the subsequent initialization, set_power_state gets called to=20
> transition to the final power state. set_power_state refers to values=20
> from the current state and without current state populated, it could=20
> result in NULL pointer dereference.
>
> Bug:https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F
> gitlab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F1698&amp;data=3D04%7C0
> 1%7Clijo.lazar%40amd.com%7C8a10ba2a0d7d4896ed1408d97e90d3cc%7C3dd8961f
> e4884e608e11a82d994e183d%7C0%7C0%7C637679982775776349%7CUnknown%7CTWFp
> bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn
> 0%3D%7C1000&amp;sdata=3DgTpG97DwoTSYBTN%2BSZYiAAL4o1VjG5n%2BaHu65s%2BADG
> E%3D&amp;reserved=3D0
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/powerplay/si_dpm.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c=20
> b/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
> index bdbbeb959c68..81f82aa05ec2 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
> @@ -6867,6 +6867,8 @@ static int si_dpm_enable(struct amdgpu_device *adev=
)
>         si_enable_auto_throttle_source(adev, AMDGPU_DPM_AUTO_THROTTLE_SRC=
_THERMAL, true);
>         si_thermal_start_thermal_controller(adev);
>
> +       ni_update_current_ps(adev, boot_ps);
> +
>         return 0;
>  }
>
> --
> 2.17.1
>
