Return-Path: <SRS0=kQKQ=CG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB86C433E2
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2020 14:16:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AE2F20848
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2020 14:16:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="M0fIr40g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AE2F20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 354EF6E4B6;
	Fri, 28 Aug 2020 14:16:15 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DC366E4B6
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2020 14:16:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gwv8d8p9dCCeCVOOe0CIQaimolysf/zF7wiT/hWcWBiBcMQFEL+PibYfqQ+k2NVP/ICQhgwMYzbUUNJcA4UDfnIpZTWKMQ4Csp2Qbb0V1+VQkE8Qn3oqipzSx+w1QbVDl/BPJDWNtolRiamEuzv/q5kn7ilnDzg/6z02ynRY0U4EP6RMB13fqI/pMxrtvCj8IWwTXPNlQ4RDGfROEsKFxT7hJXT5nENFQRFmeb9QyAQwQO5eCUWqPSAOGnK7aBxjXyzmT7VJn659/4g9duEgDdK2/uFX1J/EmW5/Yp0skFBwWqXq9pSi7/sRizHraaLHBazfLnudrhnHz3kEo2kdSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uI7rUs0GirTCEzeWOlkoDcgz1FKFdtlOHsMq2czpkFE=;
 b=c+0jBzxaOlcRV9voKcEPyq9n+lWFPVhucdhwE2a9cp84YAAWMGgcrEGtskWGgHOlG8gYGcipUpSmlvATbOIg5AQEsk8VZJ1UdjWlwTcbYFb9D15SzkXwGLa73cc+V1Ciy+va1RI0ouXYmN1ZWP29KGcu77C0gHlgwkbfX3XyQ9rqL+ebRlChWwIn58MsowcQzGjIqJLwdjzQescc2ixauWEWjyqZcPd2OKxP+yWKquqLacRRpFQ4lrNTpjXwV6jTEyCikYyu3e7VR6jl/p3w3OnRc6ab7EfZ0ipxUJ3C54BIxH3xwPH0uHSCtx42w0le7V5wltRqvAPSkV3MCMHVCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uI7rUs0GirTCEzeWOlkoDcgz1FKFdtlOHsMq2czpkFE=;
 b=M0fIr40giW5/SA/n8rRCPfe8GcrEWVCLuL7EjUbk678Ftip53WVVHLb38Y7yD6wE37wslwjtWZ6QeTz0NjPkpw653UdnjhvUOk99eQu4Ol/XudQQoP/4gPDdhqJSP+M7WPOrCTg8LtXx9h4EVKnvsWJzN3BvpW7hlVgVhP9oilM=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB3917.namprd12.prod.outlook.com (2603:10b6:208:166::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Fri, 28 Aug
 2020 14:16:11 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::889d:3c2f:a794:67fb]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::889d:3c2f:a794:67fb%7]) with mapi id 15.20.3305.032; Fri, 28 Aug 2020
 14:16:11 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Das, Nirmoy" <Nirmoy.Das@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: Re: [PATCH 1/4] drm/amd/pm: drop unnecessary feature->mutex lock
 protections(V2)
Thread-Topic: [PATCH 1/4] drm/amd/pm: drop unnecessary feature->mutex lock
 protections(V2)
Thread-Index: AQHWerRMcZx73Z0Y4Eaae2ib5VXkG6lLhD4AgAGtegCAAGRGRg==
Date: Fri, 28 Aug 2020 14:16:11 +0000
Message-ID: <MN2PR12MB4488907B07E4FF9AE362BE7BF7520@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20200825074923.32345-1-evan.quan@amd.com>
 <efc66f15-2291-dcdf-79eb-ce2085614360@amd.com>,
 <92deaaac-9ac5-8005-7070-2965367701b6@gmail.com>
In-Reply-To: <92deaaac-9ac5-8005-7070-2965367701b6@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-08-28T14:16:11.076Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [172.58.203.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a2fbf50a-0e1b-4da0-6ed3-08d84b5ceaab
x-ms-traffictypediagnostic: MN2PR12MB3917:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3917C78BD8C7D2CD05E5901EF7520@MN2PR12MB3917.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1051;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6xMTcq7tIR7AkGtLeB9xEeUY3nVIjvSqB7yvEDr9v5vDN3XlEQyHfdT65xFUpUPwwxaS8hmOP4kdFSKnD+h3aOGGahKHYD0UJ1KGWzyq/mcUO7DOzE9YXZ3QZQB6gdExpdblumpX20tCnVAGh+5PVGXmGtCk/4seBCOwnZiqt/L+gLWXD13qt4dBNmXGLohle6ODzRzDVawsMKm4XB4Dkr5/9T+T4DzkqTmsP8T306f+zGflUW+jxP4gU9MnGiTt4qEpE3jVDLEEjSdwKBVVLyT5TAYmcu0D7FR2y8exU2f2RzwrOg4vDoNecbAoaP5kEsIKpU6AD1gTZuIZKjwfOgY6X7hQhttqz63ZfLruhKo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(376002)(136003)(346002)(396003)(86362001)(2906002)(186003)(19627405001)(53546011)(52536014)(7696005)(9686003)(55016002)(166002)(6636002)(45080400002)(66476007)(66946007)(8676002)(66446008)(64756008)(66556008)(76116006)(66574015)(478600001)(8936002)(71200400001)(316002)(33656002)(5660300002)(83380400001)(110136005)(6506007)(26005)(966005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: LafoB/pPFZfrfF2tNykHetgHK0jiaIoOjq8B/Xxuf8Y8foJDE4lLDhWakuui/LGTTZpjIMgk8NHtgOsnSB7fvBMYB6RnYb09/KsagQU5dBkm1J7DUYpTGVgvGsJPjNFpo8Szz9XEGD5Y7/xtCHfLaB2B5j/MrcU2A8NpdX8CuhSGt/qaWV6zAwkUMoF5j2fEbdGit15a/PC/RcxNSdoMcUalAAzrFKjJ2u0ErwZsuf2qx/DDL+2/FZ1PjxqIS1w2eMde4lZ9n6ZEzK1hjlwRDehBh5ymJLJxrVBR95NjZRX/zMCBzbd0Ltshe6k3vgeBOQjvYqYmUyTienDO5zVJdQAx5Ds4w2ECSl7tn2+Wu+41R9ERiZHUOFtaJ+cZkEa0QNtWLMBO+TAMNqRONIY4svuJuwuc8yupDDQfyOczWaFa3Vq+L9/WepfW0TeWZ4+xSZSsMwayCtYK9/sGaJH2S/uohCbjr1QSjHPkwiUwCt0POxI2znEYqpub42xcaUIjH8OtymDRtIPCog56M4MuHAjq2b7Tp3ZHeO1lDNR2eIrSsdbVyffiWv1i892+EXXLxDyBfSKOAb4hWCecBljDNgdm/hIFX0rdKaMFdd6PiIdkCnlemqwerDUzqOJR0ZFyX+PdO1BNorrcfehvtHsQ/Q==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2fbf50a-0e1b-4da0-6ed3-08d84b5ceaab
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2020 14:16:11.8157 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BeyrHu5t6H1EMsw75Ksqytxxpj0D9ZsMjPEBVqYQfSvtQumwDUXR1RNE7zM/KW+GCaqEajQRQhGBp0uWxLj0ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3917
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
Content-Type: multipart/mixed; boundary="===============0946444980=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0946444980==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488907B07E4FF9AE362BE7BF7520MN2PR12MB4488namp_"

--_000_MN2PR12MB4488907B07E4FF9AE362BE7BF7520MN2PR12MB4488namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

This code gets called during suspend and resume and GPU reset as well.  Are=
 those cases properly covered?

Alex

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Christia=
n K=F6nig <ckoenig.leichtzumerken@gmail.com>
Sent: Friday, August 28, 2020 4:16 AM
To: Das, Nirmoy <Nirmoy.Das@amd.com>; amd-gfx@lists.freedesktop.org <amd-gf=
x@lists.freedesktop.org>
Subject: Re: [PATCH 1/4] drm/amd/pm: drop unnecessary feature->mutex lock p=
rotections(V2)

The explanation sounds sane, but since I don't know the affected code at
all the series is only Acked-by: Christian K=F6nig <christian.koenig@amd.co=
m>

Maybe wait for Alex to give you an rb if you are unsure, otherwise feel
free to commit.

Christian.

Am 27.08.20 um 08:39 schrieb Nirmoy:
> Series is Acked-by: Nirmoy Das <nirmoy.das@amd.com>
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
>> Signed-off-by: Evan Quan <evan.quan@amd.com>
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
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists=
.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Calexan=
der.deucher%40amd.com%7Ccad2767c7837431f94f308d84b2ab750%7C3dd8961fe4884e60=
8e11a82d994e183d%7C0%7C0%7C637341994162774368&amp;sdata=3Db8PVt6zfQJXYlVunp=
FMY12knU8ZlJ7UE0ojZjhAWJdY%3D&amp;reserved=3D0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7Ccad2767c7837431f94f308d84b2ab750%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637341994162774368&amp;sdata=3Db8PVt6zfQJXYlVunpFM=
Y12knU8ZlJ7UE0ojZjhAWJdY%3D&amp;reserved=3D0

--_000_MN2PR12MB4488907B07E4FF9AE362BE7BF7520MN2PR12MB4488namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
This code gets called during suspend and resume and GPU reset as well.&nbsp=
; Are those cases properly covered?</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Christian K=F6nig &lt;ckoenig=
.leichtzumerken@gmail.com&gt;<br>
<b>Sent:</b> Friday, August 28, 2020 4:16 AM<br>
<b>To:</b> Das, Nirmoy &lt;Nirmoy.Das@amd.com&gt;; amd-gfx@lists.freedeskto=
p.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> Re: [PATCH 1/4] drm/amd/pm: drop unnecessary feature-&gt;mu=
tex lock protections(V2)</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">The explanation sounds sane, but since I don't kno=
w the affected code at
<br>
all the series is only Acked-by: Christian K=F6nig &lt;christian.koenig@amd=
.com&gt;<br>
<br>
Maybe wait for Alex to give you an rb if you are unsure, otherwise feel <br=
>
free to commit.<br>
<br>
Christian.<br>
<br>
Am 27.08.20 um 08:39 schrieb Nirmoy:<br>
&gt; Series is Acked-by: Nirmoy Das &lt;nirmoy.das@amd.com&gt;<br>
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
&gt;&gt; Signed-off-by: Evan Quan &lt;evan.quan@amd.com&gt;<br>
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
&gt; amd-gfx@lists.freedesktop.org<br>
&gt; <a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps=
%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=
=3D02%7C01%7Calexander.deucher%40amd.com%7Ccad2767c7837431f94f308d84b2ab750=
%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637341994162774368&amp;amp;sd=
ata=3Db8PVt6zfQJXYlVunpFMY12knU8ZlJ7UE0ojZjhAWJdY%3D&amp;amp;reserved=3D0">
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Calex=
ander.deucher%40amd.com%7Ccad2767c7837431f94f308d84b2ab750%7C3dd8961fe4884e=
608e11a82d994e183d%7C0%7C0%7C637341994162774368&amp;amp;sdata=3Db8PVt6zfQJX=
YlVunpFMY12knU8ZlJ7UE0ojZjhAWJdY%3D&amp;amp;reserved=3D0</a><br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Calexander.deucher%40amd.com%7Ccad2767c7837431f94f308d84b2ab750%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637341994162774368&amp;amp;sdata=3D=
b8PVt6zfQJXYlVunpFMY12knU8ZlJ7UE0ojZjhAWJdY%3D&amp;amp;reserved=3D0">https:=
//nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedes=
ktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Calexander.=
deucher%40amd.com%7Ccad2767c7837431f94f308d84b2ab750%7C3dd8961fe4884e608e11=
a82d994e183d%7C0%7C0%7C637341994162774368&amp;amp;sdata=3Db8PVt6zfQJXYlVunp=
FMY12knU8ZlJ7UE0ojZjhAWJdY%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB4488907B07E4FF9AE362BE7BF7520MN2PR12MB4488namp_--

--===============0946444980==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0946444980==--
