Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EB0EC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Feb 2022 18:25:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE26310E662;
	Thu, 17 Feb 2022 18:25:26 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6ED410E684
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Feb 2022 18:25:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c5VIa4GnF50Qna9XCaySgGMLQ7GlT30y816F0DPczp4R8xTTpd4Hr2X3i8J5wAtv+vJaY6MHkrq6x666UG3GRuS5rkQaC+jRZHhZePlrI0xnPphkI87gMy4C+TRo+t/cswN3yRAJFrd2LTsXmURJsrNrpR7oufu+7ajES9g2FO+URM57UR/U9IxnpYECvtvON2b2SaFK6IQeakyhihfgf3Xr7xeFQraqGuzYbf6sXUfHBevx8lXrc+rOgYCA+y42B9Mx3GiB4FgbNJpQ529HPVx4imrkBX+ASGEb7BxdzVu2nALRQh4rJaieEMduWA/mdfrBMSUw1f+rACTZKIwRAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w7mSGk7iysDwZfysEcGDL6U2ODvthohg7JH08E67ShE=;
 b=Fwpu9hHhHCslb7LKvuBSBWenrvVWGFNncuNQ47MBP/+NjoRaxzQPNg1nQD1AzbFU8+f/hsXz50xerW+q6Z7vQet6LJHHzR8Pkzf+qMqiPORdHO/SB1uxM6Wyq5NfcLzHLDs0ea61yA8+znjOe+oxPPpOVSJF9948bddERnN3MkHE5pkXduw4tXhb3lG4ZNPNo6NQ1OX/obo+0LDFHXRSkeZ0NfRJFx6VIjU9yibdQwKpO+CeqabJVPwTwPNZgXybwyVi4sclWZJ17/5XBTbIsNq7E5QrfPt3M/9d2eoe7ku38kCV2hNMukgXrHWCLCYjUBrbkgI2vMLMAk64qUKVYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w7mSGk7iysDwZfysEcGDL6U2ODvthohg7JH08E67ShE=;
 b=jClnlXQY+YfT3nRpQEWkcqfrF6gEJk5UNGnDrsTotOofZF23ykq/8WhogNeoQEBr9vX+D6nx9cgVTAbbQC7JUeQ6k4c4HhdfDBOf1BmeMbd1CmwQEOw9mK5hVw0JZMenq0MLxzLx/XlXlIRvPfNXzYztYvy5b9wg2QRlJNYJo7Q=
Received: from DM6PR12MB3547.namprd12.prod.outlook.com (2603:10b6:5:18a::20)
 by MW3PR12MB4347.namprd12.prod.outlook.com (2603:10b6:303:2e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Thu, 17 Feb
 2022 18:25:15 +0000
Received: from DM6PR12MB3547.namprd12.prod.outlook.com
 ([fe80::64ab:286b:3178:89c4]) by DM6PR12MB3547.namprd12.prod.outlook.com
 ([fe80::64ab:286b:3178:89c4%5]) with mapi id 15.20.4995.016; Thu, 17 Feb 2022
 18:25:15 +0000
From: "StDenis, Tom" <Tom.StDenis@amd.com>
To: "Tuikov, Luben" <Luben.Tuikov@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Dynamically initialize IP instance attributes
Thread-Topic: [PATCH] drm/amdgpu: Dynamically initialize IP instance attributes
Thread-Index: AQHYJBx7X53lKqaIpkuJIOYVoAIiFKyYDYAF
Date: Thu, 17 Feb 2022 18:25:15 +0000
Message-ID: <DM6PR12MB3547FD0D228E17F075341B81F7369@DM6PR12MB3547.namprd12.prod.outlook.com>
References: <20220217163556.6491-1-luben.tuikov@amd.com>
In-Reply-To: <20220217163556.6491-1-luben.tuikov@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-02-17T18:25:15.190Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: 841506a1-afe9-b835-bcb8-5a6f2260542e
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5bb27d92-32bc-42ae-3251-08d9f242d81f
x-ms-traffictypediagnostic: MW3PR12MB4347:EE_
x-microsoft-antispam-prvs: <MW3PR12MB43474452C00FD8AA30D6EB70F7369@MW3PR12MB4347.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1cuU31AKo/eLeRXUitSyFbBslfpzD+w9hMnWeocAI1YeJCR0XjEVquO6gK0ew03E1zEF4oio/W4hGv1xHIvlXo/O23uQlwunL//Zo3YAJ9oRcX713u9TPShnqOvj+9EsLFmkO0daEvFmOJzTmOsnE11fLR5hriZyHLLNdfwu+soNOKWuHJ5vXX7ySyqFAxyirFXtjP32tYbx4ywx+RdUSkKDOeORgA8NtMlW+sY+bAbtRuI0fg3F+5AP2p1u8iRrd7kQpSt8dv9GvpMQ/5GnUw5JjykgDMxECGvTFA0To5V+bxmLpikUi/i+ADG2ky4IdOIL1VDBnD9ycxpR+GKsYJ01a0ptDCw6NgBAhb/fIqyjx+GmHN+MWb1Vi1sFJVb0sbHWnzdQCBMJCzp7F29fkicY3VXrXNQZVGCo/sGn2uVpo4rxXEgPWtb9cvHIdrVDCkYwoxWaxyV99bpMKaryAWVYRfm+zTIJlibuYtKs4OCBesqzy0+Qnngcfc6BObtM5YRl/+laEQbPK1neEstWhyAIBgwTKVgmfbASrcPsoB88OyNbNf9v6cVmoIVEo3FC389amuKQB+/JVpExC8vg+OvwXxsH4lBtAmHMAzd13aAnWYZRzr0meIeTdOPc7BVokEWKY2D0Cy4LvGRt1p1D1atuhW2H/uk6XpILDmN6+l36ltTcQSNkAOdgj8TR439ZUqarFmSIniU4pAvKhfcKDA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3547.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66946007)(110136005)(66446008)(66476007)(4326008)(76116006)(91956017)(53546011)(316002)(122000001)(38070700005)(38100700002)(508600001)(7696005)(66556008)(9686003)(71200400001)(6506007)(8676002)(2906002)(83380400001)(86362001)(5660300002)(55016003)(64756008)(8936002)(52536014)(33656002)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?lm4cht/MsccKg2ONCPzMwsqvnq0r9rzshkXLZkWFqfYLmn7K2wqbRO5HPx?=
 =?iso-8859-1?Q?TYKMV2yMAi51n6z6aad9/AnwjoIem+SQeqGCxp+1KxIxMn245buch1vBvs?=
 =?iso-8859-1?Q?3uBg40KecdpCvdainNJ2EPYOVLVuv5pblyRcTSXcfs82Ss17JqdVZ9mb+V?=
 =?iso-8859-1?Q?AiEYZvoX1+8+qBo6sixreQmbKFZCMb6y1psgEeeFDmwAKC/ZaafaXLhMKF?=
 =?iso-8859-1?Q?9NaZK3hwiU5Y4Z12k5VqiOzwpbXsyWU0FfEYRa23OBxQaLGVkSAcUdCU3Z?=
 =?iso-8859-1?Q?7gcDNebYPqbJqnO2QXEQdHP3cuSZoSvmR05lYjghSGQ0q0nBFYfhW9mTEb?=
 =?iso-8859-1?Q?Wj6PdZjY8JUr4HWiu96cR3EkgK0s+1GQUBIzhKlWGWmi25SbCRYceVNcXC?=
 =?iso-8859-1?Q?vEGd1R4VFum6ziaRSDU6Mf1dJKliGdFzBL8QmXEa3M9Lak5xyJlw0LWkOo?=
 =?iso-8859-1?Q?9uyCon6qGbCtLEEpOQ32IQJSgo0I8lDwB5FcQKhGM5djncv0TEEmzAhgPd?=
 =?iso-8859-1?Q?1v1/f01xSoi2Ffaq/AGOcXV/AOX+44pkhyBa7UQKQCM+KhSJwLXqP5r+Ey?=
 =?iso-8859-1?Q?fWFtrH1Oi6r63QR+Kwj44Howakcw8HukWq51fT/CFLPuxVDIWfkCIDTdrn?=
 =?iso-8859-1?Q?orBVnNMnH7g8oRgkWV1jG/J8qzsZ9Iloo+erDf0ujk1S+3AAlSsVNtmXxH?=
 =?iso-8859-1?Q?MdpiAWNhzgCoqGnjzQ1UR9W4oLLIMPgrgcrLiJPnpfRnaRE6Ia+EOl+kkC?=
 =?iso-8859-1?Q?5BhYVpWAgGtIXPMDmydnAyB5P1n5OnuVuwH5vylMaTLJ50D08a4jPEEKXw?=
 =?iso-8859-1?Q?7TKqFOUxn6zqSyNownGKTmgZqzzl+c3DJiWui11+PcZFeZe1HVeaIVMgT+?=
 =?iso-8859-1?Q?CZwy2pDdu+iE+CNP8ZRV3MNV6tPoIGg6MCZpJDIbGP7DO6DCKKeO5xo9WZ?=
 =?iso-8859-1?Q?OVVSjGvvfnt1dy6xVKX9S2g0DfiMyFjLhiNqgvGRuUr0Ya1ZjRbupOiI2o?=
 =?iso-8859-1?Q?h3SQKPW121ilwb9ntP/fjfePrW3246EzR6uiQ6f2mTt4VnKplZxvXRT1Ly?=
 =?iso-8859-1?Q?4F9425mUZJVgPwxAOHMWaoyfq6uxwGK3++tLlbTs5bKnt2jN7RlS1v+wN8?=
 =?iso-8859-1?Q?i1aQccECGPpoZt1o8nzAP4RtqkyBf2nfDXx3+Lg5vl58zfaTLf8ZeHxb05?=
 =?iso-8859-1?Q?n0avMluLvSQ6bxPePUHvDbH0VmDNKqNq6612iVz25wFcFwBaGFc4FnrAi/?=
 =?iso-8859-1?Q?F76kI0pNZdEypG91eRulhuGTms6ebRjnBlwHOS3iic1Y9HSEnrqzuUH5xv?=
 =?iso-8859-1?Q?7jh1sud2TcEWNFPkER0HqJCTssJCqS7e8F6GqV8GbZOPevDiN8xV3Y3Azy?=
 =?iso-8859-1?Q?wdtPS9cxc0K+5b+VU4tcijwTs3Tej4q4C+8BKeOh9X1DF76zw+J2CGflQ6?=
 =?iso-8859-1?Q?VA+foXEM/+VXP8JVJWKfDSmjNJMhbOdV5w8973aMu0VIu+EzxbUqfiosdy?=
 =?iso-8859-1?Q?IPqD2y5D5FvzXJrwkwdi/I88xIXjDBtIO5KvR7ffhS4y3rwXlbcOMDTDjd?=
 =?iso-8859-1?Q?OrJYHqU17nfd8FUhm8zSMoC8sjYZrwcHiiqrsa621z2iVX/gugCFXP6Q41?=
 =?iso-8859-1?Q?9T5niUkzK0Oyqg1rzwOVwC7+HDVwD9tswjuaKmU27FLplvxa4+yVBtwaE8?=
 =?iso-8859-1?Q?4iOg7kYLdfniJ5ObWUlldaM9uvd2olqtazKDYtVOZhQ/1BIZXCf1gPeeeO?=
 =?iso-8859-1?Q?5E63pE1gk/AYCmyfxeHun3lTY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3547.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bb27d92-32bc-42ae-3251-08d9f242d81f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2022 18:25:15.5759 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qXa41kR2iJn7i0Rr92pdFW8CoUNinb3dNepCQ+CRzouTu/uZqqLbqejItU01vStN6jIecyORp/yHYiGTxrYs4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4347
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

This works, now I'm facing other issues.  Like we call the VCN block on nav=
i10 a "uvd 2.0.0".  Originally I was only accepting exact major hits which =
meant my navi10 model had no video enc/dec block once I programmed it to ta=
ke the closest match it hit UVD 4.0.0 (pre-soc15/etc) and that's obviously =
wrong.
 Shouldn't IP discovered video enc/dec be name VCN?

On a semi related note we have no SDMA v5.x.y headers in the tree but navi1=
0+ uses it.  I guess the driver just uses SDMA 4.x.y headers because they'r=
e close enough but it means umr won't load in an SDMA model.

Which then gets us into weird conditions.  Right now I'm programming umr to=
 find the closet abs() major hit, then minor, then revision.  But I imagine=
 we'll hit cases where say version X.Y+1.Z is better than X.Y-1.Z and vice =
versa (etc with the other fields).   There's no way for umr to know if a ne=
wer or older header is better.

Tom

________________________________________
From: Tuikov, Luben <Luben.Tuikov@amd.com>
Sent: Thursday, February 17, 2022 11:35
To: amd-gfx@lists.freedesktop.org
Cc: Tuikov, Luben; Deucher, Alexander; StDenis, Tom
Subject: [PATCH] drm/amdgpu: Dynamically initialize IP instance attributes

Dynamically initialize IP instance attributes. This eliminates bugs
stemming from adding new attributes to an IP instance.

Cc: Alex Deucher <Alexander.Deucher@amd.com>
Reported-by: Tom StDenis <tom.stdenis@amd.com>
Fixes: c10b6aa7417b0a ("drm/amdgpu: Add "harvest" to IP discovery sysfs")
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c
index 6c7ec058125e1d..5848fec5c39251 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -482,16 +482,7 @@ static struct ip_hw_instance_attr ip_hw_attr[] =3D {
        __ATTR_RO(base_addr),
 };

-static struct attribute *ip_hw_instance_attrs[] =3D {
-       &ip_hw_attr[0].attr,
-       &ip_hw_attr[1].attr,
-       &ip_hw_attr[2].attr,
-       &ip_hw_attr[3].attr,
-       &ip_hw_attr[4].attr,
-       &ip_hw_attr[5].attr,
-       &ip_hw_attr[6].attr,
-       NULL,
-};
+static struct attribute *ip_hw_instance_attrs[ARRAY_SIZE(ip_hw_attr) + 1];
 ATTRIBUTE_GROUPS(ip_hw_instance);

 #define to_ip_hw_instance(x) container_of(x, struct ip_hw_instance, kobj)
@@ -789,7 +780,7 @@ static int amdgpu_discovery_sysfs_recurse(struct amdgpu=
_device *adev)
 static int amdgpu_discovery_sysfs_init(struct amdgpu_device *adev)
 {
        struct kset *die_kset;
-       int res;
+       int res, ii;

        adev->ip_top =3D kzalloc(sizeof(*adev->ip_top), GFP_KERNEL);
        if (!adev->ip_top)
@@ -814,6 +805,10 @@ static int amdgpu_discovery_sysfs_init(struct amdgpu_d=
evice *adev)
                goto Err;
        }

+       for (ii =3D 0; ii < ARRAY_SIZE(ip_hw_attr); ii++)
+               ip_hw_instance_attrs[ii] =3D &ip_hw_attr[ii].attr;
+       ip_hw_instance_attrs[ii] =3D NULL;
+
        res =3D amdgpu_discovery_sysfs_recurse(adev);

        return res;

base-commit: f736148ca7bf82654141a4411409c2d7a9e2269b
--
2.35.1.129.gb80121027d

