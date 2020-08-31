Return-Path: <SRS0=7vr2=CJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB29C433E6
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2020 07:01:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A3152072D
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2020 07:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="UmCM2jMV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A3152072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB56089CA0;
	Mon, 31 Aug 2020 07:01:22 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADE3B89CA0
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2020 07:01:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V7pNeueJg8fZfBbpGhypdBg8Vi+iJS/ArwFQmOSpKNpgbqHatB3aEMTYlUK56D6eM77yE+4iMNgAYbK2hI36XCtqnGdjHukdpWXran7F1+JeYgqcOkpzsevmovYndRs6eg8IrUftkHez4uk3YeYkD9yzH3zlxVTDRkz/ppPuA171DybXHAoNRNg9wjFLjtPz6/p1ksmgmAdvXwLhAxsNU+YnnwwoLmF3KzPjVQvC2v6eUNL4y4KGKkVVdzrjZRw4Kmxb8gfT6R4kqULGztYPMG00VdMY9nNMKI3tFw02lJKcLSOmNJdRAPv49/lJAiAESdW6OTbU8lc2Q9k35jV2xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OGgB7QY+rh/Kbu36qDl0hwesfvS7XNLnTPA/DrevNL4=;
 b=oGdqlHS4+dF1i3Q+IhVK0N0A4a2Z3JNCZkvBmirR0FsqXT3Q91+TR01K56TlvYhXAbE5IHfLkgYFmESbBjh0Zo2Tk5etSPlxnUNxsk8s+ikdcvN6Q2EtbfJ4RDvCetQzP/kYgf3I+aPpEtETTLl0BaaD5R/P02oVagPOqCno7DZd+C8fRZo+KNw5xDlDG9L6ZWGNjR3qyqhAnAhIlVUFsICpLmP7ZomCFU7aB2xQvcUErLTqX/DVnQmfgrtz6wVbxf1Qq74nCI4MrVxMRrETJ94u0EVfbPt0hAgVmAkpTqQZx4N2ycNkX/m6BXcdI5Ir2mirLmvLli1SI31yDd0r1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OGgB7QY+rh/Kbu36qDl0hwesfvS7XNLnTPA/DrevNL4=;
 b=UmCM2jMV3zftARWXgBUBEvbslBbOjAkC0Zgylm50PqYZFYYy35fkwiYfJqnfn3n2LKFTrKmwDq2tJTVG2hZaZAIOAgOMN0Vm10s4tRIB3EJW8DkbOqrnCOlltF8+gqUaEoqBtedIWbd7MG/oYPhMRRwaGTrcZEfczzrzKQxLRlw=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4219.namprd12.prod.outlook.com (2603:10b6:5:217::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.23; Mon, 31 Aug 2020 07:01:15 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3326.025; Mon, 31 Aug 2020
 07:01:15 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Das, Nirmoy"
 <Nirmoy.Das@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH 1/4] drm/amd/pm: drop unnecessary feature->mutex lock
 protections(V2)
Thread-Topic: [PATCH 1/4] drm/amd/pm: drop unnecessary feature->mutex lock
 protections(V2)
Thread-Index: AQHWerRL/uAEDSukPkeF+dR0FbQ/86lLhD4AgAGtegCAAGRugIAEKlzQ
Date: Mon, 31 Aug 2020 07:01:15 +0000
Message-ID: <DM6PR12MB2619C097D3F4CFACF43A9793E4510@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20200825074923.32345-1-evan.quan@amd.com>
 <efc66f15-2291-dcdf-79eb-ce2085614360@amd.com>,
 <92deaaac-9ac5-8005-7070-2965367701b6@gmail.com>
 <MN2PR12MB4488907B07E4FF9AE362BE7BF7520@MN2PR12MB4488.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB4488907B07E4FF9AE362BE7BF7520@MN2PR12MB4488.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-08-28T14:16:11.076Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c9996508-44ac-4a9b-c668-08d84d7ba741
x-ms-traffictypediagnostic: DM6PR12MB4219:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB42192BECEC54657E1142380DE4510@DM6PR12MB4219.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1051;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /NqYpj5/JajUT0iuGKuv8Soq/od8Pc/goL0D/HEk7m/Luj/asPLWnfaEhxkJ30rKrxESlyqcsmyKbkd6L1IZlQ9og+V7GHga80b0TMBvbeLQSpTH8gYevamSLYN38Ft2u6Ug1IR1gzf+v2eysSLwcgvNJHTVp4tBkoUHp2xN0NM6R/N1K3RiC5TPzpKzrOxaGZ9gv3ZVH3Vur4jjgie5FbmIwLUV2lhxPqkOqmSpfV+2HtIuBWuQx8tJCOySXKVTgdho9Xp3JhhMbV76jlO2TMmG11T4T54gmKe7GnHIudpEIoEuBQd5kRobNanB0j2GxS8x12vsU0g3lHFWmkJpvU+bbRV098zpFCnat8LZTTo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(39860400002)(136003)(366004)(396003)(71200400001)(66476007)(166002)(45080400002)(55016002)(53546011)(66574015)(8676002)(64756008)(8936002)(66446008)(33656002)(76116006)(9686003)(66556008)(66946007)(186003)(6506007)(7696005)(83380400001)(26005)(966005)(52536014)(110136005)(478600001)(316002)(2906002)(5660300002)(6636002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: +sK3XN9qsmuH5JZP4f7Cg+OZsSlnvfmH7tvuNzIkN+dDTtSKy4p9yNr0wjeGY25Lp98+TdeJiVnDUCS4csxCgTtUV2SrJ+4R2RA2o/1F3ow6JYP90haOz43qUdRwINHb5WuDye4kVOqDmAsLPiJ7woUIbHfugFfGYBU8/pH08kNbqH6nbfaiVKKCshl5dkbU+yfTQicw1E090oDEqWbm+o9YjdM91D0qkDp2rPzFShrxLs/5cbRwl3cy5a3z+txg2Sd1Zt7AIhDt8LUBmTVsxGzo6Ye1bNgIufVQSyt//SdupPr24k+FBe6lyKRXPpy5LO+E2eH926Hbve6dfacQx58FVs1uegJr1080BxmCVKK0HcF8/m+oNBnD5M5/f8Fh1TNv/yIGb0szVVNfDXvcH0/sMJvRRdw36ykaTE8RIkFTqlwhbCCi0G0k1SagjCnL776So26dP53+xGvavB9zagnd5UD2kLVykzNAfwuXpVgYSQusVeXnKDVePib25Orx3TNL/BcxGf77ewVDQaMypbvRlgWHrYT9m2H6aaQ3bDKNtpe1AqRgBFRpIpyPynCRgxiv34UCllXbEFFAOt2D6P5ptT0Eo6lvDt911OvAY7eBDbfnlWQC3lusWKnGwhWKWQlE+af5OSh39eB0kOFYYg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9996508-44ac-4a9b-c668-08d84d7ba741
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2020 07:01:15.3797 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ctK4hJ/HcpdF8f5GZvodRyUznb5Nk+j8Byr/x6RLzvijn4urpUYQdaC0fPkoMrLa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4219
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
Content-Type: multipart/mixed; boundary="===============0063924704=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0063924704==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB2619C097D3F4CFACF43A9793E4510DM6PR12MB2619namp_"

--_000_DM6PR12MB2619C097D3F4CFACF43A9793E4510DM6PR12MB2619namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Yes.
These two APIs get called only during hw/smu initialization. And although t=
here needs hw initialization also on resume/gpu reset.
They share no race conditions(there cannot be another gpu reset/resume unle=
ss current gpu reset/resume done).

BR
Evan
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Deucher,=
 Alexander
Sent: Friday, August 28, 2020 10:16 PM
To: Das, Nirmoy <Nirmoy.Das@amd.com>; amd-gfx@lists.freedesktop.org; Koenig=
, Christian <Christian.Koenig@amd.com>
Subject: Re: [PATCH 1/4] drm/amd/pm: drop unnecessary feature->mutex lock p=
rotections(V2)


[AMD Official Use Only - Internal Distribution Only]


[AMD Official Use Only - Internal Distribution Only]

This code gets called during suspend and resume and GPU reset as well.  Are=
 those cases properly covered?

Alex

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Christian K=F6nig <ckoenig.leichtzume=
rken@gmail.com<mailto:ckoenig.leichtzumerken@gmail.com>>
Sent: Friday, August 28, 2020 4:16 AM
To: Das, Nirmoy <Nirmoy.Das@amd.com<mailto:Nirmoy.Das@amd.com>>; amd-gfx@li=
sts.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <amd-gfx@lists.fr=
eedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Subject: Re: [PATCH 1/4] drm/amd/pm: drop unnecessary feature->mutex lock p=
rotections(V2)

The explanation sounds sane, but since I don't know the affected code at
all the series is only Acked-by: Christian K=F6nig <christian.koenig@amd.co=
m<mailto:christian.koenig@amd.com>>

Maybe wait for Alex to give you an rb if you are unsure, otherwise feel
free to commit.

Christian.

Am 27.08.20 um 08:39 schrieb Nirmoy:
> Series is Acked-by: Nirmoy Das <nirmoy.das@amd.com<mailto:nirmoy.das@amd.=
com>>
>
>
> On 8/25/20 9:49 AM, Evan Quan wrote:
>> As these operations are performed in hardware setup and there
>> is actually no race conditions during this period considering:
>> 1. the hardware setup is serial and cannnot be in parallel
>> 2. all other operations can be performed only after hardware
>>     setup complete.
>>
>> V2: rich the commit log description
>>
>> Change-Id: I096d7ab0855ff59b0ecb56fd9d6d9946b3605fc8
>> Signed-off-by: Evan Quan <evan.quan@amd.com<mailto:evan.quan@amd.com>>
>> ---
>>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c      | 4 ----
>>   drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 2 --
>>   2 files changed, 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> index 09dc5303762b..b7cad8ef6153 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> @@ -361,20 +361,16 @@ static int
>> smu_get_driver_allowed_feature_mask(struct smu_context *smu)
>>       int ret =3D 0;
>>       uint32_t allowed_feature_mask[SMU_FEATURE_MAX/32];
>>   -    mutex_lock(&feature->mutex);
>>       bitmap_zero(feature->allowed, SMU_FEATURE_MAX);
>> -    mutex_unlock(&feature->mutex);
>>         ret =3D smu_get_allowed_feature_mask(smu, allowed_feature_mask,
>>                            SMU_FEATURE_MAX/32);
>>       if (ret)
>>           return ret;
>>   -    mutex_lock(&feature->mutex);
>>       bitmap_or(feature->allowed, feature->allowed,
>>                 (unsigned long *)allowed_feature_mask,
>>                 feature->feature_num);
>> -    mutex_unlock(&feature->mutex);
>>         return ret;
>>   }
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
>> b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
>> index 548db1edd352..28a19ffd22a1 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
>> @@ -721,7 +721,6 @@ int smu_v11_0_set_allowed_mask(struct smu_context
>> *smu)
>>       int ret =3D 0;
>>       uint32_t feature_mask[2];
>>   -    mutex_lock(&feature->mutex);
>>       if (bitmap_empty(feature->allowed, SMU_FEATURE_MAX) ||
>> feature->feature_num < 64)
>>           goto failed;
>>   @@ -738,7 +737,6 @@ int smu_v11_0_set_allowed_mask(struct
>> smu_context *smu)
>>           goto failed;
>>     failed:
>> -    mutex_unlock(&feature->mutex);
>>       return ret;
>>   }
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists=
.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Calexan=
der.deucher%40amd.com%7Ccad2767c7837431f94f308d84b2ab750%7C3dd8961fe4884e60=
8e11a82d994e183d%7C0%7C0%7C637341994162774368&amp;sdata=3Db8PVt6zfQJXYlVunp=
FMY12knU8ZlJ7UE0ojZjhAWJdY%3D&amp;reserved=3D0<https://nam11.safelinks.prot=
ection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Fl=
istinfo%2Famd-gfx&data=3D02%7C01%7Cevan.quan%40amd.com%7C9e52b030677540d81c=
be08d84b5ced7a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637342209834431=
339&sdata=3DRlb%2B33bxmwO7W5Ke4sQnS8HRsGlrFkf%2F99YWmSW7OWk%3D&reserved=3D0=
>

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7Ccad2767c7837431f94f308d84b2ab750%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637341994162774368&amp;sdata=3Db8PVt6zfQJXYlVunpFM=
Y12knU8ZlJ7UE0ojZjhAWJdY%3D&amp;reserved=3D0<https://nam11.safelinks.protec=
tion.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flis=
tinfo%2Famd-gfx&data=3D02%7C01%7Cevan.quan%40amd.com%7C9e52b030677540d81cbe=
08d84b5ced7a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63734220983443133=
9&sdata=3DRlb%2B33bxmwO7W5Ke4sQnS8HRsGlrFkf%2F99YWmSW7OWk%3D&reserved=3D0>

--_000_DM6PR12MB2619C097D3F4CFACF43A9793E4510DM6PR12MB2619namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Yes. <o:p></o:p></p>
<p class=3D"MsoNormal">These two APIs get called only during hw/smu initial=
ization. And although there needs hw initialization also on resume/gpu rese=
t.<o:p></o:p></p>
<p class=3D"MsoNormal">They share no race conditions(there cannot be anothe=
r gpu reset/resume unless current gpu reset/resume done).<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">BR<o:p></o:p></p>
<p class=3D"MsoNormal">Evan<o:p></o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> amd-gfx &lt;amd-gfx-bounces@lists.freed=
esktop.org&gt;
<b>On Behalf Of </b>Deucher, Alexander<br>
<b>Sent:</b> Friday, August 28, 2020 10:16 PM<br>
<b>To:</b> Das, Nirmoy &lt;Nirmoy.Das@amd.com&gt;; amd-gfx@lists.freedeskto=
p.org; Koenig, Christian &lt;Christian.Koenig@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH 1/4] drm/amd/pm: drop unnecessary feature-&gt;mu=
tex lock protections(V2)<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif;color:#0078D7">[AMD Official Use Only - Internal D=
istribution Only]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif;color:#0078D7">[AMD Official Use Only - Internal D=
istribution Only]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">This co=
de gets called during suspend and resume and GPU reset as well.&nbsp; Are t=
hose cases properly covered?<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Alex<o:=
p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists=
.freedesktop.org">amd-gfx-bounces@lists.freedesktop.org</a>&gt; on behalf o=
f Christian K=F6nig &lt;<a href=3D"mailto:ckoenig.leichtzumerken@gmail.com"=
>ckoenig.leichtzumerken@gmail.com</a>&gt;<br>
<b>Sent:</b> Friday, August 28, 2020 4:16 AM<br>
<b>To:</b> Das, Nirmoy &lt;<a href=3D"mailto:Nirmoy.Das@amd.com">Nirmoy.Das=
@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Subject:</b> Re: [PATCH 1/4] drm/amd/pm: drop unnecessary feature-&gt;mu=
tex lock protections(V2)</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal">The explanation sounds sane, but since I don't know =
the affected code at
<br>
all the series is only Acked-by: Christian K=F6nig &lt;<a href=3D"mailto:ch=
ristian.koenig@amd.com">christian.koenig@amd.com</a>&gt;<br>
<br>
Maybe wait for Alex to give you an rb if you are unsure, otherwise feel <br=
>
free to commit.<br>
<br>
Christian.<br>
<br>
Am 27.08.20 um 08:39 schrieb Nirmoy:<br>
&gt; Series is Acked-by: Nirmoy Das &lt;<a href=3D"mailto:nirmoy.das@amd.co=
m">nirmoy.das@amd.com</a>&gt;<br>
&gt;<br>
&gt;<br>
&gt; On 8/25/20 9:49 AM, Evan Quan wrote:<br>
&gt;&gt; As these operations are performed in hardware setup and there<br>
&gt;&gt; is actually no race conditions during this period considering:<br>
&gt;&gt; 1. the hardware setup is serial and cannnot be in parallel<br>
&gt;&gt; 2. all other operations can be performed only after hardware<br>
&gt;&gt; &nbsp;&nbsp;&nbsp; setup complete.<br>
&gt;&gt;<br>
&gt;&gt; V2: rich the commit log description<br>
&gt;&gt;<br>
&gt;&gt; Change-Id: I096d7ab0855ff59b0ecb56fd9d6d9946b3605fc8<br>
&gt;&gt; Signed-off-by: Evan Quan &lt;<a href=3D"mailto:evan.quan@amd.com">=
evan.quan@amd.com</a>&gt;<br>
&gt;&gt; ---<br>
&gt;&gt; &nbsp; drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; | 4 ----<br>
&gt;&gt; &nbsp; drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 2 --<br>
&gt;&gt; &nbsp; 2 files changed, 6 deletions(-)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c <br>
&gt;&gt; b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
&gt;&gt; index 09dc5303762b..b7cad8ef6153 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
&gt;&gt; +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
&gt;&gt; @@ -361,20 +361,16 @@ static int <br>
&gt;&gt; smu_get_driver_allowed_feature_mask(struct smu_context *smu)<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t allowed_feature_mask[SMU_F=
EATURE_MAX/32];<br>
&gt;&gt; &nbsp; -&nbsp;&nbsp;&nbsp; mutex_lock(&amp;feature-&gt;mutex);<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bitmap_zero(feature-&gt;allowed, SM=
U_FEATURE_MAX);<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;feature-&gt;mutex);<br>
&gt;&gt; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_get_allowed_feat=
ure_mask(smu, allowed_feature_mask,<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; SMU_FEATURE_MAX/32);<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;=
<br>
&gt;&gt; &nbsp; -&nbsp;&nbsp;&nbsp; mutex_lock(&amp;feature-&gt;mutex);<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bitmap_or(feature-&gt;allowed, feat=
ure-&gt;allowed,<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; (unsigned long *)allowed_feature_mask,<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; feature-&gt;feature_num);<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;feature-&gt;mutex);<br>
&gt;&gt; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&gt; &nbsp; }<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c <br>
&gt;&gt; b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c<br>
&gt;&gt; index 548db1edd352..28a19ffd22a1 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c<br>
&gt;&gt; +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c<br>
&gt;&gt; @@ -721,7 +721,6 @@ int smu_v11_0_set_allowed_mask(struct smu_cont=
ext <br>
&gt;&gt; *smu)<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t feature_mask[2];<br>
&gt;&gt; &nbsp; -&nbsp;&nbsp;&nbsp; mutex_lock(&amp;feature-&gt;mutex);<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bitmap_empty(feature-&gt;allowe=
d, SMU_FEATURE_MAX) || <br>
&gt;&gt; feature-&gt;feature_num &lt; 64)<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto failed=
;<br>
&gt;&gt; &nbsp; @@ -738,7 +737,6 @@ int smu_v11_0_set_allowed_mask(struct <=
br>
&gt;&gt; smu_context *smu)<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto failed=
;<br>
&gt;&gt; &nbsp; &nbsp; failed:<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;feature-&gt;mutex);<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&gt; &nbsp; }<br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedes=
ktop.org</a><br>
&gt; <a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps=
%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02=
%7C01%7Cevan.quan%40amd.com%7C9e52b030677540d81cbe08d84b5ced7a%7C3dd8961fe4=
884e608e11a82d994e183d%7C0%7C0%7C637342209834431339&amp;sdata=3DRlb%2B33bxm=
wO7W5Ke4sQnS8HRsGlrFkf%2F99YWmSW7OWk%3D&amp;reserved=3D0">
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Calex=
ander.deucher%40amd.com%7Ccad2767c7837431f94f308d84b2ab750%7C3dd8961fe4884e=
608e11a82d994e183d%7C0%7C0%7C637341994162774368&amp;amp;sdata=3Db8PVt6zfQJX=
YlVunpFMY12knU8ZlJ7UE0ojZjhAWJdY%3D&amp;amp;reserved=3D0</a><br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01=
%7Cevan.quan%40amd.com%7C9e52b030677540d81cbe08d84b5ced7a%7C3dd8961fe4884e6=
08e11a82d994e183d%7C0%7C0%7C637342209834431339&amp;sdata=3DRlb%2B33bxmwO7W5=
Ke4sQnS8HRsGlrFkf%2F99YWmSW7OWk%3D&amp;reserved=3D0">https://nam11.safelink=
s.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.org%2Fmailm=
an%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Calexander.deucher%40amd.co=
m%7Ccad2767c7837431f94f308d84b2ab750%7C3dd8961fe4884e608e11a82d994e183d%7C0=
%7C0%7C637341994162774368&amp;amp;sdata=3Db8PVt6zfQJXYlVunpFMY12knU8ZlJ7UE0=
ojZjhAWJdY%3D&amp;amp;reserved=3D0</a><o:p></o:p></p>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM6PR12MB2619C097D3F4CFACF43A9793E4510DM6PR12MB2619namp_--

--===============0063924704==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0063924704==--
