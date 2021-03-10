Return-Path: <SRS0=9uSV=II=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D932C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 10:16:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C1EF64FDF
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 10:16:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C1EF64FDF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20DCC6EA00;
	Wed, 10 Mar 2021 10:16:36 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B5EC6EA00
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Mar 2021 10:16:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cy03OdH1O6oR+EewPXjhNG1tRtMJfIosGmTSYLtCGgiHKC63zUiKD/HASgRM8qtr6VYKnc4cfMN82wHdCSkG8WCm6Ebi7EeEfXH0pDIEcze8YyxtwHQkdUyU1PsyG3RSffTzjNjV36y0TSGSHqe4DlC6evTugWEtx6gwMdd9OvkWFubOkpgoRiNpNogPD6Di7HbQnZ9DBPNyCRqgj6dYU55Q3JetGoaY6mgVYhtkz5YBOJ0nI83H7bsySipl4FYL2GMXPRgSQBSlahhttz09qNUQDkosMiv7YYNOFUJcb5yh83lo5fyXiy3gc+spUu4GN31ZJ2S3LNKoAENJ9BmObg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ooi4FgkbPJGWlCq+6i8Oju9iDxZtXczTvdAB5riIfTg=;
 b=To1s/CV9MfiJ2fbpeLN8KwyZJ4FcjkLV7iTChwrAsq3etjHXMHujKmtiaKVW51d7At7j/MP/R9W7djUTWs1utnokARwTkgz91pW6AiMXQLLra1JkPgmB5ghP4VZEu+MDVfDSgDUUsOT3vBzlDsDGKZ0jxaHronX6ie0ANEnIXDjZVGvyXhwhITZe+kK5VNhZ+cIcxZD4bIYqrPZvQMerzxk1YJPB/fY8xvR00iZLVdSMFMoUNS9f4/KsMH88w+s97pbyQKbhHkE+5BjJgOPz2r9/BXTncchylq0w0xVjBuANGFuAaHpxLkOs4SHY8oCUIqtkRy0fdy09DnUqbqx6yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ooi4FgkbPJGWlCq+6i8Oju9iDxZtXczTvdAB5riIfTg=;
 b=X9Cl3WkXm9dIzBk5xLN6ix5zGr6VFoPcS25LSpfgr8S0uVMI9MhUexV9KISJFTRgjyTJopG9HkGfi+C6bHUCMdsrB/iZX1Ij/s0BRXQe1zNSF34u7N27vos8R4fj4GfLWo3NSsXcMjKpBRt2nfdxI0BCHTBXKPmTtcBZd5zQCHw=
Received: from BYAPR12MB3238.namprd12.prod.outlook.com (2603:10b6:a03:13b::20)
 by BY5PR12MB4308.namprd12.prod.outlook.com (2603:10b6:a03:20a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Wed, 10 Mar
 2021 10:16:30 +0000
Received: from BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::5870:fcd6:b13a:c49c]) by BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::5870:fcd6:b13a:c49c%5]) with mapi id 15.20.3912.030; Wed, 10 Mar 2021
 10:16:30 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Bhardwaj, Rajneesh" <Rajneesh.Bhardwaj@amd.com>, Alex Deucher
 <alexdeucher@gmail.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
Subject: RE: [PATCH 4/7] drm/amdgpu: track what pmops flow we are in
Thread-Topic: [PATCH 4/7] drm/amdgpu: track what pmops flow we are in
Thread-Index: AQHXFJoszTCu2jIp0UiflCPhm8zDhap7LzcAgACeo4CAABtAgIABGKng
Date: Wed, 10 Mar 2021 10:16:30 +0000
Message-ID: <BYAPR12MB3238C0DD77975C8F0AFA4375FB919@BYAPR12MB3238.namprd12.prod.outlook.com>
References: <20210309041012.23367-1-alexander.deucher@amd.com>
 <20210309041012.23367-4-alexander.deucher@amd.com>
 <MN2PR12MB4549198E8D86DC4176EC6C9E97929@MN2PR12MB4549.namprd12.prod.outlook.com>
 <CADnq5_OauPrtpYZQb+C3qRkU15u5Hp3tpXXM7ERC63Lh9sj6TA@mail.gmail.com>
 <f5b4bfba-6d01-bccd-cf8c-8036e2a4320a@amd.com>
In-Reply-To: <f5b4bfba-6d01-bccd-cf8c-8036e2a4320a@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=3b18bef8-04cc-47e6-9075-385fced1a978;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-03-10T10:09:40Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [139.227.235.92]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c78ad689-5354-4e8a-d14a-08d8e3ad92f4
x-ms-traffictypediagnostic: BY5PR12MB4308:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB4308E6F31427F445A9CF4F32FB919@BY5PR12MB4308.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W2JNw0ydDv1ajalUvOlU3Kiurz8WB1nrh7/yLCUf8D5fDRo176W0F5L2oDOK6W4M87L+YD8EbCMJonqaO5f9nPeLBOGZxnIf+Rf21UFJHqYvngQqG0/5JL0tIAdSAp3n4m5wInUN8TxT4dYpyYX+RjUwy5sKMg3F0pkkuZIJwizuWQd6qr7HmrfvAZC/0ALH+2sf0H3ebl02oSGlUDa6OTn89HbbXk5IwQKTyDHpFX9/rfuksgPf3UOmYFMDzpTqagyzaDbsrciH95grbNWoKdG6/4qRkqg8vuxDXIpoZAjFSaE1R6m0Ka8KLUsm4eTpZplcwPRhwVYcu8R8JYLHM+MVtqZL1cfjY8kzRLZwKRG/eb6I051O3zaf8YW2SQEvRCYNh1ox4jKTIYJSRlxLjaGXP8GFfjTG1HbKqHGfLrVgb+cUtKSMdBlGQx4S/f2oFqczWScrhiVc3CVoCyTBI40OT6Xwg0kC1ZfVAi3uF8DI7ucAhaJSwblpZAf4LLUxR1mLyidkM5EyobZtKgN4fzYgSPnc5Bp1+PSkgbAa88AYsBwpyRPQxmjJbCutkbqxwLnZb7Xjdrh0D0QHZRArBRke8tL8WOayDAFBJI7ueSk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3238.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(376002)(136003)(396003)(366004)(66556008)(26005)(5660300002)(64756008)(66946007)(76116006)(66446008)(8936002)(66476007)(71200400001)(86362001)(966005)(7696005)(30864003)(4326008)(45080400002)(6506007)(186003)(53546011)(52536014)(6636002)(478600001)(2906002)(110136005)(55016002)(54906003)(83380400001)(9686003)(316002)(8676002)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?1SFcPILoqbLmeOXSceGSKl55APiABS3zCoGocknqS+MdzksKvo3+oHtNRS74?=
 =?us-ascii?Q?PPSYzwVB6Sqk5ndTGQ2OLTcx67Gb3CoqdfqLz/hpEgSoO6E8YOrRHI64IWTT?=
 =?us-ascii?Q?X2FQgurjkOJi97GOI6BdbWDVA0VrOzWxbqhpoQbwOL4d+6cp82O9dIihfiAD?=
 =?us-ascii?Q?yBJyppQywu+QrjfHMw7EYrhbkuHZ1cWGQx+F+15kMjFdJPwMceWRvf+HRoSX?=
 =?us-ascii?Q?9vbqreh9MRZkPzMcpnpK7H/PM6GzITT9QjQGhdF82LYzJqjH3uN8T28VyIf7?=
 =?us-ascii?Q?9idfWG7upOR4LQ39H9IMpNtY9B2F2IqirSfF8/mTKmXvl9xAG3oeamTdPF/1?=
 =?us-ascii?Q?CEfW+ChydwdNdgy5WPSVFpsZd8XKLuUIU23Ikrk+R1mfdCKC/US4ppwpiypP?=
 =?us-ascii?Q?uj5U8G6hT2TIqyoVO/TgLSjU0gwWDKBoa74GH/Hub9xIUAOd/W4aG4zNBhku?=
 =?us-ascii?Q?nYFv7E+Pglo4NNswwV1h5OrSJlrnHQHsYdIDjnq6pvfzVS5UBq+fH6ZYw0mc?=
 =?us-ascii?Q?clbzBWell4oFAE8jTMD4uOYqgDHBHF7eWBUvUToUwRdyV8NSYmFDYGDhgYyv?=
 =?us-ascii?Q?afiYY+0z1WCJELF8VPPsxNReMaAqrrhE47s5P4WmbckaDLVozENNOASPzzLC?=
 =?us-ascii?Q?4yCis7HKOjRsyivaJeQmWMYGfM7yrc13s1KsXG+3eX4y/xxuVNDHoiDmLroH?=
 =?us-ascii?Q?2aXPcZE8DMUEZx/2HBfycPAiIoV8VeE9DJK4uiwCbXwqcIQRN9jxL8fKKr6u?=
 =?us-ascii?Q?cyN9lBfXXh4SP5nizFH12uplAPAKD85VDIC/WzuRQsYNQPLu0NnUzTQB9sEw?=
 =?us-ascii?Q?haGICbHqs2NbllPe/7JkSxEgTUEs94g0CpjzF3y3dJClS0h46z+ayPDHLWhL?=
 =?us-ascii?Q?Do/GYqiR5Yilt2aL6V7fKp5c3FtJRAZJhRwRoBPHp52c8UUv5G02SWZHv8EY?=
 =?us-ascii?Q?Msp9MGn2vDbz2SqtatAgrnJDkSh/NwAtHKA5rFeK8QJYtKfni2agPiE+M5S7?=
 =?us-ascii?Q?TaRv1I2sR60FlhJmlYdNfokzDI4ERSzW7YHRNzXpxjemeUtVAnn5WNqOjTYX?=
 =?us-ascii?Q?n500UbvJWg4o/amnG1KUXUDui4faTO01l6+l1geffFZ3N0AblldVKdLEaN4H?=
 =?us-ascii?Q?SvUuT072eAWKTHyNV4KOYIVKhTyXBvMINZXlJbq1zraagOoDOjGRc9DfZ0C2?=
 =?us-ascii?Q?NlbBbi7sV9ukAQuFBOLoLzn4Az/vTFv20Zu7moge0TIbIjyDH5AVFsn9L79V?=
 =?us-ascii?Q?AUKvOZ+8rD9FkmXvQ9EAvazp+WXI+lpncmwaOlF6ocTOOCV2Q28OEM7HuX+1?=
 =?us-ascii?Q?B7Kg5Dz+vUQEugt7afyj+0zO?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3238.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c78ad689-5354-4e8a-d14a-08d8e3ad92f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2021 10:16:30.5691 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OMVYmzXmdb8isOvsJGLtX27ikCmp1RZBalQk2q8FpnQKcQ4TlIq+B+73SbzbLnKy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4308
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Maybe we can use the acpi_target_system_state() interface to identify the system-wide suspend target level Sx and then can parse the return code by the following macro definition. If have bandwidth will update and refine the AMDGPU Sx[0..5] suspend/resume sequence.

#define ACPI_STATE_S0                   (u8) 0
#define ACPI_STATE_S1                   (u8) 1
#define ACPI_STATE_S2                   (u8) 2
#define ACPI_STATE_S3                   (u8) 3
#define ACPI_STATE_S4                   (u8) 4
#define ACPI_STATE_S5                   (u8) 5

Thanks,
Prike
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Bhardwaj, Rajneesh
> Sent: Wednesday, March 10, 2021 1:25 AM
> To: Alex Deucher <alexdeucher@gmail.com>; Lazar, Lijo
> <Lijo.Lazar@amd.com>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-
> gfx@lists.freedesktop.org
> Subject: Re: [PATCH 4/7] drm/amdgpu: track what pmops flow we are in
>
> pm_message_t events seem to be the right thing to use here instead of
> driver's privately managed power states. Please have a look
>
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Felixir
> .bootlin.com%2Flinux%2Fv4.7%2Fsource%2Fdrivers%2Fgpu%2Fdrm%2Fi915
> %2Fi915_drv.c%23L714&amp;data=04%7C01%7CPrike.Liang%40amd.com%7
> C473ede68e7a347ff606b08d8e3204e94%7C3dd8961fe4884e608e11a82d994e
> 183d%7C0%7C0%7C637509075233985095%7CUnknown%7CTWFpbGZsb3d8e
> yJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D
> %7C1000&amp;sdata=Y%2BNKrW2LfzB157fZ%2FuLn7QAu%2BmxVgHjzG8LO
> CH8z6J4%3D&amp;reserved=0
>
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Felixir
> .bootlin.com%2Flinux%2Fv4.7%2Fsource%2Fdrivers%2Fgpu%2Fdrm%2Fdrm_
> sysfs.c%23L43&amp;data=04%7C01%7CPrike.Liang%40amd.com%7C473ede6
> 8e7a347ff606b08d8e3204e94%7C3dd8961fe4884e608e11a82d994e183d%7C
> 0%7C0%7C637509075233985095%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiM
> C4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000
> &amp;sdata=svJsR97DiTwcbYHn3Y9dDV0YQCVzx5HLiebqQ9mTRY8%3D&am
> p;reserved=0
>
> Thanks,
>
> Rajneesh
>
>
> On 3/9/2021 10:47 AM, Alex Deucher wrote:
> > [CAUTION: External Email]
> >
> > On Tue, Mar 9, 2021 at 1:19 AM Lazar, Lijo <Lijo.Lazar@amd.com> wrote:
> >> [AMD Public Use]
> >>
> >> This seems a duplicate of dev_pm_info states. Can't we reuse that?
> > Are you referring to the PM_EVENT_ messages in
> > dev_pm_info.power_state?  Maybe.  I was not able to find much
> > documentation on how those should be used.  Do you know?
> >
> > Alex
> >
> >
> >> Thanks,
> >> Lijo
> >>
> >> -----Original Message-----
> >> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> >> Alex Deucher
> >> Sent: Tuesday, March 9, 2021 9:40 AM
> >> To: amd-gfx@lists.freedesktop.org
> >> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> >> Subject: [PATCH 4/7] drm/amdgpu: track what pmops flow we are in
> >>
> >> We reuse the same suspend and resume functions for all of the pmops
> states, so flag what state we are in so that we can alter behavior deeper in
> the driver depending on the current flow.
> >>
> >> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu.h       | 20 +++++++-
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c   | 58
> +++++++++++++++++++----
> >>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c |  3 +-
> >>   3 files changed, 70 insertions(+), 11 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> >> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> >> index d47626ce9bc5..4ddc5cc983c7 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> >> @@ -347,6 +347,24 @@ int amdgpu_device_ip_block_add(struct
> >> amdgpu_device *adev,  bool amdgpu_get_bios(struct amdgpu_device
> >> *adev);  bool amdgpu_read_bios(struct amdgpu_device *adev);
> >>
> >> +/*
> >> + * PM Ops
> >> + */
> >> +enum amdgpu_pmops_state {
> >> +       AMDGPU_PMOPS_NONE = 0,
> >> +       AMDGPU_PMOPS_PREPARE,
> >> +       AMDGPU_PMOPS_COMPLETE,
> >> +       AMDGPU_PMOPS_SUSPEND,
> >> +       AMDGPU_PMOPS_RESUME,
> >> +       AMDGPU_PMOPS_FREEZE,
> >> +       AMDGPU_PMOPS_THAW,
> >> +       AMDGPU_PMOPS_POWEROFF,
> >> +       AMDGPU_PMOPS_RESTORE,
> >> +       AMDGPU_PMOPS_RUNTIME_SUSPEND,
> >> +       AMDGPU_PMOPS_RUNTIME_RESUME,
> >> +       AMDGPU_PMOPS_RUNTIME_IDLE,
> >> +};
> >> +
> >>   /*
> >>    * Clocks
> >>    */
> >> @@ -1019,8 +1037,8 @@ struct amdgpu_device {
> >>          u8                              reset_magic[AMDGPU_RESET_MAGIC_NUM];
> >>
> >>          /* s3/s4 mask */
> >> +       enum amdgpu_pmops_state         pmops_state;
> >>          bool                            in_suspend;
> >> -       bool                            in_hibernate;
> >>
> >>          /*
> >>           * The combination flag in_poweroff_reboot_com used to
> >> identify the poweroff diff --git
> >> a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >> index 3e6bb7d79652..0312c52bd39d 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >> @@ -1297,34 +1297,54 @@ amdgpu_pci_shutdown(struct pci_dev *pdev)
> static int amdgpu_pmops_prepare(struct device *dev)  {
> >>          struct drm_device *drm_dev = dev_get_drvdata(dev);
> >> +       struct amdgpu_device *adev = drm_to_adev(drm_dev);
> >> +       int r;
> >>
> >> +       adev->pmops_state = AMDGPU_PMOPS_PREPARE;
> >>          /* Return a positive number here so
> >>           * DPM_FLAG_SMART_SUSPEND works properly
> >>           */
> >>          if (amdgpu_device_supports_boco(drm_dev))
> >> -               return pm_runtime_suspended(dev) &&
> >> +               r= pm_runtime_suspended(dev) &&
> >>                          pm_suspend_via_firmware();
> >> -
> >> -       return 0;
> >> +       else
> >> +               r = 0;
> >> +       adev->pmops_state = AMDGPU_PMOPS_NONE;
> >> +       return r;
> >>   }
> >>
> >>   static void amdgpu_pmops_complete(struct device *dev)  {
> >> +       struct drm_device *drm_dev = dev_get_drvdata(dev);
> >> +       struct amdgpu_device *adev = drm_to_adev(drm_dev);
> >> +
> >> +       adev->pmops_state = AMDGPU_PMOPS_COMPLETE;
> >>          /* nothing to do */
> >> +       adev->pmops_state = AMDGPU_PMOPS_NONE;
> >>   }
> >>
> >>   static int amdgpu_pmops_suspend(struct device *dev)  {
> >>          struct drm_device *drm_dev = dev_get_drvdata(dev);
> >> +       struct amdgpu_device *adev = drm_to_adev(drm_dev);
> >> +       int r;
> >>
> >> -       return amdgpu_device_suspend(drm_dev, true);
> >> +       adev->pmops_state = AMDGPU_PMOPS_SUSPEND;
> >> +       r = amdgpu_device_suspend(drm_dev, true);
> >> +       adev->pmops_state = AMDGPU_PMOPS_NONE;
> >> +       return r;
> >>   }
> >>
> >>   static int amdgpu_pmops_resume(struct device *dev)  {
> >>          struct drm_device *drm_dev = dev_get_drvdata(dev);
> >> +       struct amdgpu_device *adev = drm_to_adev(drm_dev);
> >> +       int r;
> >>
> >> -       return amdgpu_device_resume(drm_dev, true);
> >> +       adev->pmops_state = AMDGPU_PMOPS_RESUME;
> >> +       r = amdgpu_device_resume(drm_dev, true);
> >> +       adev->pmops_state = AMDGPU_PMOPS_NONE;
> >> +       return r;
> >>   }
> >>
> >>   static int amdgpu_pmops_freeze(struct device *dev) @@ -1333,9
> +1353,9 @@ static int amdgpu_pmops_freeze(struct device *dev)
> >>          struct amdgpu_device *adev = drm_to_adev(drm_dev);
> >>          int r;
> >>
> >> -       adev->in_hibernate = true;
> >> +       adev->pmops_state = AMDGPU_PMOPS_FREEZE;
> >>          r = amdgpu_device_suspend(drm_dev, true);
> >> -       adev->in_hibernate = false;
> >> +       adev->pmops_state = AMDGPU_PMOPS_NONE;
> >>          if (r)
> >>                  return r;
> >>          return amdgpu_asic_reset(adev); @@ -1344,8 +1364,13 @@
> >> static int amdgpu_pmops_freeze(struct device *dev)  static int
> amdgpu_pmops_thaw(struct device *dev)  {
> >>          struct drm_device *drm_dev = dev_get_drvdata(dev);
> >> +       struct amdgpu_device *adev = drm_to_adev(drm_dev);
> >> +       int r;
> >>
> >> -       return amdgpu_device_resume(drm_dev, true);
> >> +       adev->pmops_state = AMDGPU_PMOPS_THAW;
> >> +       r = amdgpu_device_resume(drm_dev, true);
> >> +       adev->pmops_state = AMDGPU_PMOPS_NONE;
> >> +       return r;
> >>   }
> >>
> >>   static int amdgpu_pmops_poweroff(struct device *dev) @@ -1354,17
> +1379,24 @@ static int amdgpu_pmops_poweroff(struct device *dev)
> >>          struct amdgpu_device *adev = drm_to_adev(drm_dev);
> >>          int r;
> >>
> >> +       adev->pmops_state = AMDGPU_PMOPS_POWEROFF;
> >>          adev->in_poweroff_reboot_com = true;
> >>          r =  amdgpu_device_suspend(drm_dev, true);
> >>          adev->in_poweroff_reboot_com = false;
> >> +       adev->pmops_state = AMDGPU_PMOPS_NONE;
> >>          return r;
> >>   }
> >>
> >>   static int amdgpu_pmops_restore(struct device *dev)  {
> >>          struct drm_device *drm_dev = dev_get_drvdata(dev);
> >> +       struct amdgpu_device *adev = drm_to_adev(drm_dev);
> >> +       int r;
> >>
> >> -       return amdgpu_device_resume(drm_dev, true);
> >> +       adev->pmops_state = AMDGPU_PMOPS_RESTORE;
> >> +       r = amdgpu_device_resume(drm_dev, true);
> >> +       adev->pmops_state = AMDGPU_PMOPS_NONE;
> >> +       return r;
> >>   }
> >>
> >>   static int amdgpu_pmops_runtime_suspend(struct device *dev) @@ -
> 1389,6 +1421,7 @@ static int amdgpu_pmops_runtime_suspend(struct
> device *dev)
> >>                  }
> >>          }
> >>
> >> +       adev->pmops_state = AMDGPU_PMOPS_RUNTIME_SUSPEND;
> >>          adev->in_runpm = true;
> >>          if (amdgpu_device_supports_px(drm_dev))
> >>                  drm_dev->switch_power_state =
> DRM_SWITCH_POWER_CHANGING; @@ -1396,6 +1429,7 @@ static int
> amdgpu_pmops_runtime_suspend(struct device *dev)
> >>          ret = amdgpu_device_suspend(drm_dev, false);
> >>          if (ret) {
> >>                  adev->in_runpm = false;
> >> +               adev->pmops_state = AMDGPU_PMOPS_NONE;
> >>                  return ret;
> >>          }
> >>
> >> @@ -1412,6 +1446,8 @@ static int
> amdgpu_pmops_runtime_suspend(struct device *dev)
> >>                  amdgpu_device_baco_enter(drm_dev);
> >>          }
> >>
> >> +       adev->pmops_state = AMDGPU_PMOPS_NONE;
> >> +
> >>          return 0;
> >>   }
> >>
> >> @@ -1425,6 +1461,7 @@ static int
> amdgpu_pmops_runtime_resume(struct device *dev)
> >>          if (!adev->runpm)
> >>                  return -EINVAL;
> >>
> >> +       adev->pmops_state = AMDGPU_PMOPS_RUNTIME_RESUME;
> >>          if (amdgpu_device_supports_px(drm_dev)) {
> >>                  drm_dev->switch_power_state =
> >> DRM_SWITCH_POWER_CHANGING;
> >>
> >> @@ -1449,6 +1486,7 @@ static int
> amdgpu_pmops_runtime_resume(struct device *dev)
> >>          if (amdgpu_device_supports_px(drm_dev))
> >>                  drm_dev->switch_power_state = DRM_SWITCH_POWER_ON;
> >>          adev->in_runpm = false;
> >> +       adev->pmops_state = AMDGPU_PMOPS_NONE;
> >>          return 0;
> >>   }
> >>
> >> @@ -1464,6 +1502,7 @@ static int amdgpu_pmops_runtime_idle(struct
> device *dev)
> >>                  return -EBUSY;
> >>          }
> >>
> >> +       adev->pmops_state = AMDGPU_PMOPS_RUNTIME_IDLE;
> >>          if (amdgpu_device_has_dc_support(adev)) {
> >>                  struct drm_crtc *crtc;
> >>
> >> @@ -1504,6 +1543,7 @@ static int amdgpu_pmops_runtime_idle(struct
> >> device *dev)
> >>
> >>          pm_runtime_mark_last_busy(dev);
> >>          pm_runtime_autosuspend(dev);
> >> +       adev->pmops_state = AMDGPU_PMOPS_NONE;
> >>          return ret;
> >>   }
> >>
> >> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> >> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> >> index 502e1b926a06..05a15f858a06 100644
> >> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> >> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> >> @@ -1327,7 +1327,8 @@ static int smu_disable_dpms(struct
> smu_context *smu)
> >>          bool use_baco = !smu->is_apu &&
> >>                  ((amdgpu_in_reset(adev) &&
> >>                    (amdgpu_asic_reset_method(adev) ==
> AMD_RESET_METHOD_BACO)) ||
> >> -                ((adev->in_runpm || adev->in_hibernate) &&
> amdgpu_asic_supports_baco(adev)));
> >> +                ((adev->in_runpm || (adev->pmops_state ==
> AMDGPU_PMOPS_FREEZE))
> >> +                 && amdgpu_asic_supports_baco(adev)));
> >>
> >>          /*
> >>           * For custom pptable uploading, skip the DPM features
> >> --
> >> 2.29.2
> >>
> >> _______________________________________________
> >> amd-gfx mailing list
> >> amd-gfx@lists.freedesktop.org
> >> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flis
> >> ts.freedesktop.org%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=04%7C01%7C
> >>
> Prike.Liang%40amd.com%7C473ede68e7a347ff606b08d8e3204e94%7C3dd89
> 61fe4
> >>
> 884e608e11a82d994e183d%7C0%7C0%7C637509075233985095%7CUnknow
> n%7CTWFpb
> >>
> GZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6
> Mn
> >>
> 0%3D%7C1000&amp;sdata=yYtPSR7eqLfZzYn1N%2FCDvpp%2Fxr6lERvs8w7d
> uAiaX9g
> >> %3D&amp;reserved=0
> _______________________________________________
> >> amd-gfx mailing list
> >> amd-gfx@lists.freedesktop.org
> >> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flis
> >> ts.freedesktop.org%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=04%7C01%7C
> >>
> Prike.Liang%40amd.com%7C473ede68e7a347ff606b08d8e3204e94%7C3dd89
> 61fe4
> >>
> 884e608e11a82d994e183d%7C0%7C0%7C637509075233995092%7CUnknow
> n%7CTWFpb
> >>
> GZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6
> Mn
> >>
> 0%3D%7C1000&amp;sdata=Kl90CvT0F7esbrGUTi1bGhA9Le7H7KZ3umrBcAAb
> Y6o%3D&
> >> amp;reserved=0
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> > s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=04%7C01%7CPr
> >
> ike.Liang%40amd.com%7C473ede68e7a347ff606b08d8e3204e94%7C3dd896
> 1fe4884
> >
> e608e11a82d994e183d%7C0%7C0%7C637509075233995092%7CUnknown%7
> CTWFpbGZsb
> >
> 3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0
> %3D%
> >
> 7C1000&amp;sdata=Kl90CvT0F7esbrGUTi1bGhA9Le7H7KZ3umrBcAAbY6o%3
> D&amp;re
> > served=0
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.f
> reedesktop.org%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=04%7C01%7CPrike.Liang%40amd.com%7C473ede68e7a347ff6
> 06b08d8e3204e94%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C
> 637509075233995092%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwM
> DAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdat
> a=Kl90CvT0F7esbrGUTi1bGhA9Le7H7KZ3umrBcAAbY6o%3D&amp;reserved=
> 0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
