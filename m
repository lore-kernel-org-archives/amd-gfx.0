Return-Path: <SRS0=+f/p=33=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5374C352A2
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2020 08:28:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DB4E20726
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2020 08:28:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0nB8JBJw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DB4E20726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 196996EA03;
	Fri,  7 Feb 2020 08:28:44 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 115546EA03
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2020 08:28:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EHY/w6+GNbSK9DN+gbRS/sFCfbJZ9HA1NqQHi2j12K1gPOdOONGbYNJ2olzKUTAdszhslvf+GeXevqYHoRcoTIaaH+n6NM0UOyM1xrAjTvFXSZ59Y3GLWjTlJX4AKgJjqmgD1y+9cFVfVwAd0dpoo3ijc5OF4hq+cb3DljNGxJGL01D7BTvra4hjenXA1FQlKtL3lIr4mrPRfJZKcfhmIBZPq5u0paye+7X0yeMibFeCZ4CNhKsmg66AEd/OK05mmBZGrINQW06yJJ1RquiLreYCgDItJ77RJ8AaquV9JDZel5GpsAs82VCDVNTkMHmFZVTFBdzFU2oFV5pYaZf2cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8GJntB4U9+W2ANA/gLwm2/5/oflSoSyYQlVneCqpUF4=;
 b=YnfrbsLtYm6UQ3GDdpxtxduikEak9SBwD7VerNdli7LwK34h8e82pojZovsL8Z9QygPPKshlHDTk7YcECkfMn5zUeBmac+ZFcxOBQsh7AUcNIX2tBxe/jsElMrudHqxjp26myWasmdPws/XYJozhAnDLo8XUx8wghq4xlTuPC8++BO9SIoa1kHSCdr49hr+dEoqgk2ZzuZFSefKuOleM6IuGvusBjO2nKtMFO+BOsZQYUKebWKYMriWEP6ESuywpej2BUxb9t/CG38PGC1Kf7ju7R/knJ22atupNqBjfuZGSF4KD6aDBd5F8gVG5ysk9RHGwatfbapvzcPxWK8ZBSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8GJntB4U9+W2ANA/gLwm2/5/oflSoSyYQlVneCqpUF4=;
 b=0nB8JBJwpDZC8CyHA89DVvBx46TznKFFelV6PZAb6+wA2LbtTocKsXJU+BAWTkBT/Otu3nAifbEUTVe6zkh9jiO+0119GWS1ldggUYJq8PODoMV00hvWpsGN7J2SF7Vj5XoCO5iJeNjG1nPKQkyNupmc6FANxsg76vjclRHZEfI=
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB3519.namprd12.prod.outlook.com (20.179.83.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.23; Fri, 7 Feb 2020 08:28:41 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47%5]) with mapi id 15.20.2707.023; Fri, 7 Feb 2020
 08:28:41 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amd/powerplay: handle features disablement for baco
 reset in SMU FW
Thread-Topic: [PATCH] drm/amd/powerplay: handle features disablement for baco
 reset in SMU FW
Thread-Index: AQHV3MYumNK/HjkYh020IGrp7JbPaqgOMhYAgAEzg8A=
Date: Fri, 7 Feb 2020 08:28:41 +0000
Message-ID: <MN2PR12MB3344D5998333EC893754FF3BE41C0@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <20200206081920.18766-1-evan.quan@amd.com>
 <CADnq5_Obdf0pL8vuereUPGsVZWPaHX1J3Fkni3_ZFbUOxFMrfw@mail.gmail.com>
In-Reply-To: <CADnq5_Obdf0pL8vuereUPGsVZWPaHX1J3Fkni3_ZFbUOxFMrfw@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
x-originating-ip: [27.196.83.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 11140643-f7f5-4b16-6b67-08d7aba7bd28
x-ms-traffictypediagnostic: MN2PR12MB3519:|MN2PR12MB3519:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB35197AFA81F18BB54BC12D19E41C0@MN2PR12MB3519.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0306EE2ED4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10001)(10009020)(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(189003)(199004)(52536014)(8676002)(54906003)(5660300002)(6506007)(8936002)(81156014)(81166006)(2906002)(316002)(66476007)(66946007)(966005)(71200400001)(4326008)(55016002)(45080400002)(186003)(64756008)(9686003)(66556008)(33656002)(66446008)(76116006)(7696005)(6916009)(26005)(86362001)(478600001)(357404004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3519;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GdupV0E9grryj6BzBAUrgPVPQfLq+qgQMMxoj7Eyu3pEcm8OL+j4SLhpBWQruXOxjEgQ6o29fDIMJtJD+u1vUkVblH5KPpAm4In99qztt5ujZGJwXO8RMDrmlr0VCsGQ8Bu42T/PWqSOf1g2iyiM1HvKGz+DvbzW31Zsj20/i6DjwGRAZULsiS50FoENCiAgW6foq712H1zzNb6swHqIEV1RmHnG2e7UqksyFKx5TN72l8mRydANDbKaKe8ADbTQggGZ3kdqkOlF7hODBcW4ERMjf/Z/MPiXgYLeXtSkKrBYVaeSCKRtaKxfiC91mMVN1MNLwBJ8/geQjQwRTwoAEyKo8aGCM+aP48TJGZdxkQ3ZEyhPc/j0eQJVUr6hWyD0Cb0oVriSuy89ApiXh/taSs8d7u9aE01sg6gj1rib/vFqztT/e/kbE/7t1g74gHtOaMROnkkXNHZtCQlgyrq1UPL1MyLRQSHUnCx3UCwKyIBNCYlRR3a5zUEYDxYv8Yk5yOxhPIbT/uF06r9f0vhEy17Z/EE47MX/cipwpR4w/YdAq6dfq9MT0SjAVyxpkScabNIVp5H4wMoHn8oX/I6E+EvUDG1mTsr0qGPJ8v6q3WA9pioz5lUJqRUvcXKx+YNcgLVBdrdDPjgRHQSA+gemkDtM0NbmpPEqqCSBym7/SfK2cE2nA9vtd0M4DUbpDkSJ
x-ms-exchange-antispam-messagedata: C7f0bIfD9POt9yFlWmCbupDV2+9R52xQ5dk6cBEiP1EgbCnlYUbBhIYAvYXU5kAjkb7LOoDCMRAksHLGX0jSNOI6P8/ZpUfsWKhOn2YKEZ647bkMDlq3O5yCtrNNcFYcyoyiKaNDRzuVgNGrO4kVNA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11140643-f7f5-4b16-6b67-08d7aba7bd28
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2020 08:28:41.6476 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8epdoraJH0d1mjbsk0Nb54ciV0SpH6YAyeelgbNMTgybE+2xDv93bEchp8ZTDoLy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3519
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

>Do we need the in_gpu_reset check here?  Is there ever a case where would
>ever want to execute the rest of this?  What if we enable BACO for power
>savings on arcturus?
That is used to rule out the system suspend case.
But yes, it may cause some problem for the runtime suspend case(which uses baco for power saving).
How can we know whether it's a runtime suspend or just system suspend?

>-----Original Message-----
>From: Alex Deucher <alexdeucher@gmail.com>
>Sent: Thursday, February 6, 2020 10:01 PM
>To: Quan, Evan <Evan.Quan@amd.com>
>Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Zhang, Hawking
><Hawking.Zhang@amd.com>
>Subject: Re: [PATCH] drm/amd/powerplay: handle features disablement for
>baco reset in SMU FW
>
>On Thu, Feb 6, 2020 at 3:19 AM Evan Quan <evan.quan@amd.com> wrote:
>>
>> SMU FW will handle the features disablement for baco reset on
>> Arcturus.
>>
>> Change-Id: Ifd87a09de2fca0c67c041afbd5e711973769119a
>> Signed-off-by: Evan Quan <evan.quan@amd.com>
>> ---
>>  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 53
>> +++++++++++++++++-----
>>  1 file changed, 42 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
>> b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
>> index 9d1075823681..efd10e6fa9ef 100644
>> --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
>> +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
>> @@ -1467,24 +1467,39 @@ void smu_late_fini(void *handle)
>>         smu_send_smc_msg(smu, SMU_MSG_PrepareMp1ForShutdown);  }
>>
>> -static int smu_suspend(void *handle)
>> +static int smu_disabled_dpms(struct smu_context *smu)
>>  {
>> -       int ret;
>> -       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> -       struct smu_context *smu = &adev->smu;
>> -       bool baco_feature_is_enabled = false;
>> +       struct amdgpu_device *adev = smu->adev;
>> +       uint32_t smu_version;
>> +       int ret = 0;
>>
>> -       if (!smu->pm_enabled)
>> -               return 0;
>> +       ret = smu_get_smc_version(smu, NULL, &smu_version);
>> +       if (ret) {
>> +               pr_err("Failed to get smu version.\n");
>> +               return ret;
>> +       }
>>
>> -       if(!smu->is_apu)
>> -               baco_feature_is_enabled = smu_feature_is_enabled(smu,
>SMU_FEATURE_BACO_BIT);
>> +       /*
>> +        * For baco reset on Arcturus, this operation
>> +        * (disable all smu feature) will be handled by SMU FW.
>> +        */
>> +       if (adev->in_gpu_reset &&
>> +           (amdgpu_asic_reset_method(adev) ==
>AMD_RESET_METHOD_BACO) &&
>> +           (adev->asic_type == CHIP_ARCTURUS && smu_version > 0x360e00))
>> +               return 0;
>
>Do we need the in_gpu_reset check here?  Is there ever a case where would
>ever want to execute the rest of this?  What if we enable BACO for power
>savings on arcturus?
>
>>
>> +       /* Disable all enabled SMU features */
>>         ret = smu_system_features_control(smu, false);
>> -       if (ret)
>> +       if (ret) {
>> +               pr_err("Failed to disable smu features.\n");
>>                 return ret;
>> +       }
>>
>> -       if (baco_feature_is_enabled) {
>> +       /* For baco reset, need to leave BACO feature enabled */
>> +       if (adev->in_gpu_reset &&
>> +           (amdgpu_asic_reset_method(adev) ==
>AMD_RESET_METHOD_BACO) &&
>> +           !smu->is_apu &&
>> +           smu_feature_is_enabled(smu, SMU_FEATURE_BACO_BIT)) {
>
>This change will break BACO for power savings on navi1x.  I think we can drop
>this hunk.
>
>>                 ret = smu_feature_set_enabled(smu, SMU_FEATURE_BACO_BIT,
>true);
>>                 if (ret) {
>>                         pr_warn("set BACO feature enabled failed,
>> return %d\n", ret); @@ -1492,6 +1507,22 @@ static int smu_suspend(void
>*handle)
>>                 }
>>         }
>>
>> +       return ret;
>> +}
>> +
>> +static int smu_suspend(void *handle)
>> +{
>> +       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +       struct smu_context *smu = &adev->smu;
>> +       int ret;
>> +
>> +       if (!smu->pm_enabled)
>> +               return 0;
>> +
>> +       ret = smu_disabled_dpms(smu);
>> +       if (ret)
>> +               return ret;
>> +
>>         smu->watermarks_bitmap &= ~(WATERMARKS_LOADED);
>>
>>         if (adev->asic_type >= CHIP_NAVI10 &&
>> --
>> 2.25.0
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
>> s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-
>gfx&amp;data=02%7C01%7Cev
>>
>an.quan%40amd.com%7Ce4212e8faa2849ebda5008d7ab0cfbfd%7C3dd8961fe
>4884e6
>>
>08e11a82d994e183d%7C0%7C0%7C637165944568797358&amp;sdata=M9jaswf
>JV%2Bq
>> KLZTxff%2Bju81y47M9WKT2iULEZjHBHcw%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
