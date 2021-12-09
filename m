Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44B0AC43219
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Dec 2021 17:01:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5157A10EBE1;
	Thu,  9 Dec 2021 16:54:45 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2058.outbound.protection.outlook.com [40.107.212.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1014891BB
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Dec 2021 15:46:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H7K86WGxM8aCM+46eixicFlQcHfZM6ptkqCkCkFBzHKnY/nDzpQcYOtugl9ixQLyLi340oGMj8bo5EoinakQ/6VCGTsYqXe4fGY/7YJwV/pz2IBKdaNTTqU60kgOwNGov8Gh0K2s189IMwwYC/AoeQFtH2H9BVPuOu+2VK0urXt6ZCfvoCsqgntuaa1sFPXFQv7vUXawCNVNRmzsJQW5YpFrs/NeNv3JGG9orPnZpsaTgKrHaMITgwF7zQxG8gqN/pJdpXhVl8r6TWiD54XAjh73gejvP6h/DZGQyH2M/jCSSfglsPpnmh/OQqzksQmgIxOHRFxTDCPaVOUQJhYWhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u7zKbIbfFv1Gcz2YEV8QzoQBitntZ/WEYHI+i8IEfqM=;
 b=YdrtI5rF/iA+jZA0UD2UOG0mGScj8u+okC6Aa8/r+5xaNHDO32Y94uJqLJWoIcmLrAJtrOxGwJnVWZ23pVa+VGOLd7KkKnXecsiXBVBRgiaLHhfuQHxNey5sQDSHi1LoyyM8ULHp/oxVpQN8Ghf3olK+qOAztTa3BzrW5/6Odd3eT0py2Kly/J6sQgD3AEvAJ3cLtuYw6XqdxVh0K+kK5dDAppNqKGyedP0UMHBGvwXz9BKB+PPbN7N3TJihD16JVeQ3JQ1lIFqXfn9gdJDIRAKhs9GWHXe9xe79Npzs1RApbK2Xn2wiE5AtTsMmuFcmSdoGFeH4nhgs5rlLHBmUbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u7zKbIbfFv1Gcz2YEV8QzoQBitntZ/WEYHI+i8IEfqM=;
 b=LO5zjuvb2RuWHsZ+4fiTHKy0F1r7945Q/GIDp6C5XZLmiSG4E4C/TDMSBgWpsjbdodTUwTwCFMNScrNqfLCYULm7UNqgte5vgz96epVBFIxpHr4ti/qfqaFwAvOMOy3mP7Az9LG3OHrsOJ9edPfmJPamn0ALhWgHgLTtaKvnFE4=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5173.namprd12.prod.outlook.com (2603:10b6:208:308::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Thu, 9 Dec
 2021 15:46:36 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::f170:3712:b17e:bd65]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::f170:3712:b17e:bd65%6]) with mapi id 15.20.4778.013; Thu, 9 Dec 2021
 15:46:36 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Quan, Evan" <Evan.Quan@amd.com>
Subject: Re: [PATCH] drm/amdgpu: don't skip runtime pm get on A+A config
Thread-Topic: [PATCH] drm/amdgpu: don't skip runtime pm get on A+A config
Thread-Index: AQHX6n2vGct6KKHl7EqN1CPYjx2QW6wmRugAgABVLgCAAApSAIADqRkAgAADRuA=
Date: Thu, 9 Dec 2021 15:46:36 +0000
Message-ID: <BL1PR12MB51442E00587BEC974E2D77C1F7709@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20211206084551.92502-1-christian.koenig@amd.com>
 <DM6PR12MB26194050848510738D3DF81CE46E9@DM6PR12MB2619.namprd12.prod.outlook.com>
 <462b2fbf-2d14-cc49-1b48-56b80b68b3ba@gmail.com>
 <DM6PR12MB261917D411F14C76089BA492E46E9@DM6PR12MB2619.namprd12.prod.outlook.com>
 <d0f0e37a-9dbe-c3ff-2123-b358a3c7ab04@gmail.com>
In-Reply-To: <d0f0e37a-9dbe-c3ff-2123-b358a3c7ab04@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-12-09T15:46:36.127Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
suggested_attachment_session_id: 209351dc-732f-c881-8f1a-413fbc6fb55f
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 04937ff2-6176-4850-9085-08d9bb2b1586
x-ms-traffictypediagnostic: BL1PR12MB5173:EE_
x-microsoft-antispam-prvs: <BL1PR12MB51734BEFBFDFE9A87FF05BFBF7709@BL1PR12MB5173.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M5RnT5ZQfiHEMmN6drLW4XQcXa8ff9W969AAWwfCupA2h/92rqa4Pcyu9IQLcwjibfD3QWedy1gsq6n/bprRUcJX2Z2OVPN6/n5pKjj61SJvVuQtXhNYPGq3egGHEnF70FJ9ow1LNFn8cofFPPJ5mfnZNg4ha4EVqeW5ddH7EDFkypuP+T3v/DslzInwShJenAeXCp8kocxikepODvE9TBPsZwzlsrpk4J+LhWILuxrXL7BwIKp60j1+GKUy0njmSdi6QA1XeM8PwGHnVjto3z3rxOqOl0d77N17bOD7KsHJ0CTV1+lLKkElPjCITCQVJUzHbwFE++OoG1pmOa4Cp01WgeU9ZF0/ZIKVZcmXtQI2jXZCXluLpLHhWirqM/lS1IeWrAdCSxuCBZm+9KhhlpzK/16Zl1fP53oL3WF6EdHmd1VUMHzyLcvn/QVPlcWxACrSKMA0hN++itvo6S1+tMWiPkttbkdfpL8177ZPMW95/a+wZW9/whOkCj+S/DHH6Hw3K2MKP2ysW39qWcCY3PyYuCXet82uU9nu5wZMedt54lZNxxGpjNoHOz/h3g4owuq7TPVu4vVlfxhG0WGaxgokDH5LZU26cA/XUlzBkJi/X42Inp80vfEZImpYedByRNUusYts0frOdQLUd7cjaW4aEKv6e5lZHHhUVom2TzbIuZ7AAvySXdbsAwUpM6pi0k3Sgbd9JBsr0LV3dF0/Og==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(83380400001)(9686003)(38100700002)(26005)(4326008)(186003)(122000001)(316002)(2906002)(52536014)(19627405001)(38070700005)(53546011)(6506007)(33656002)(8936002)(76116006)(6636002)(8676002)(7696005)(86362001)(66946007)(66556008)(55016003)(64756008)(66476007)(66446008)(5660300002)(110136005)(71200400001)(508600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?hZIRjp5C5HPAEXytebovEnBkLTI5POo9vBYhHRcwLn5tzY2YtFIJm3BrGF?=
 =?iso-8859-1?Q?3LqaY2z+FwXtxO4KXwn30i9JKqkt4zKQISgfd5IIAvLs+lEWEKP23VHeel?=
 =?iso-8859-1?Q?NQdJWh95aahAZP789eXGSfCM0mJk2+lVhWDzr72UN+sOhdp6DX3tI3q/w9?=
 =?iso-8859-1?Q?eop/gdGWLVy0p7NnJb7ukE6Zyh7nRJul2sFyyVzHoUEUUAtd3wYjLIZlXY?=
 =?iso-8859-1?Q?TBPR9Krn+lwJYaTzMbcc7G2MyUJtK87XX9F0YWG01XSJFGRqxQ4lqC0aPG?=
 =?iso-8859-1?Q?37i6u2as3qkkGGQhp2DwlTbBoTrW5s1b5zMfjQEQ8a2uhpGtIAPafV1W+q?=
 =?iso-8859-1?Q?4AVD+as/U3MqqkSiJ89DnFMDSTtFM/y2WBuU1ctotagdtFU2tUvozXS8tv?=
 =?iso-8859-1?Q?WD2XLYR/otN8NPM7Y8uR55AYOqU9P8ITGQzHwuy2TSLA6h+12BYU8dPNCZ?=
 =?iso-8859-1?Q?jXRLgMltwjioKiqptRrtdFV36VoH1SIxBgnQr0mfW5OYJk+XNuZpL+JAAY?=
 =?iso-8859-1?Q?jE9OHfdXe8+TBZw5SKr/oquRCgULWn1GcLslKZeTqGUTfoNIGJ+arE3Ek9?=
 =?iso-8859-1?Q?OR6MzE7aTG+JndN/zrn35w9lLjafk0Ntqb/OU0NLc557ONEW2fTl6lUhWv?=
 =?iso-8859-1?Q?shR3hwdJBKDtAPXHHmq4oZBwq5vGHRxFOXUAu+0Xy+3hWxhT9MrnMbIS8t?=
 =?iso-8859-1?Q?DzG7AwYrJ6abj2mGJyh6C/Db4f4ojd0u+bBmosy9qKuJzwXsRrdFdgBo4s?=
 =?iso-8859-1?Q?ckj3Ohz1fcQVSU/+jitGUcrFTPIHGA8637vvxYbWNG2aLOiEBj5VV5hygU?=
 =?iso-8859-1?Q?Qn4jwg2X3MKUJorpwkFLM6r5Z3AEe+jCzraTOJ3+oqCxrkrx12t6IHT18M?=
 =?iso-8859-1?Q?Eq6D9WTE5DoAicqpzP/AF8O/xPO5cnP2MWxs4wVJmxlZ4c5PmVsj/XLxKf?=
 =?iso-8859-1?Q?JDOridkE1aZjQ01Ejyq7FzheYmOJkVIQpcGwnfffQsr3uqIeoDgh1cfHjk?=
 =?iso-8859-1?Q?9B4gw1q30jxp5j0+jHRk9dOdUmePbabKmAh0O5kMGAPbyDLMx6pY6PAXRX?=
 =?iso-8859-1?Q?xaZIxZwKcfxkguW8DNet+WtZ540c9jxVnpbRKKRlIWnXvIcoUfwxM0OmsR?=
 =?iso-8859-1?Q?CPleqJy8aiHkzczB5Wxfmc9D+w33RH1kY+YjUMmCfaXYqfidtmEspjZdxj?=
 =?iso-8859-1?Q?ka433sJw8qiRtxAaUZjozeaXT4sK/qjjTum+tI1ibVBC80Bx8IaXEGPQXY?=
 =?iso-8859-1?Q?ET/LpNko9mPXHbDWqmR1rcBFvLQP78xqnlLxL0XHBnDpW7ewtjCsDbttHG?=
 =?iso-8859-1?Q?/ZiqnohmXHmV4fVTxriKkp16H4EeXGjAu52uW0iqiQuUP9M5KTZcBG1f3U?=
 =?iso-8859-1?Q?rqxIeiuiZ4MtvK/Esx7BKf47p+kXJwKDVV3oYQlic21vJ2C8aFCLdDotPV?=
 =?iso-8859-1?Q?7cn0bGx2cxHYbUOGCPxfNneYXH+IT0R8YQkBV00NiyGKfKhc2o6EfbpNHe?=
 =?iso-8859-1?Q?GAKgYJMCtn0cSvUufAoZVkn0Rgw/y4aRWbvYXXTiFBFKc4SMRjxRAqeKXj?=
 =?iso-8859-1?Q?64EIUhcKkZkp7VUITPadTRPCSPK+uzaR8jLqf74ElxQeuVg2iDvKq7oUfS?=
 =?iso-8859-1?Q?ilPlGuqtX+55qYJhWfv9H6m9/o49Uaf4fym5IhRn5SBd8QPYaJ43vrLLsO?=
 =?iso-8859-1?Q?E0BBwg+/XN6SyGD+zL0=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB51442E00587BEC974E2D77C1F7709BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04937ff2-6176-4850-9085-08d9bb2b1586
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2021 15:46:36.7982 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: APaTpQMaSCA4e082ytxLzLB0l9im6a76I7ntzKi4WZB3MuNvPNhfJZQyQj/wbhjzU+WV43DDjKhOXmqYa24njA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5173
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB51442E00587BEC974E2D77C1F7709BL1PR12MB5144namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[Public]

No objections from me.
Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>
Sent: Thursday, December 9, 2021 10:34 AM
To: Quan, Evan <Evan.Quan@amd.com>; Deucher, Alexander <Alexander.Deucher@a=
md.com>
Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: don't skip runtime pm get on A+A config

Am 07.12.21 um 08:40 schrieb Quan, Evan:
> [AMD Official Use Only]
>> -----Original Message-----
>> From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>
>> Sent: Tuesday, December 7, 2021 3:03 PM
>> To: Quan, Evan <Evan.Quan@amd.com>; Deucher, Alexander
>> <Alexander.Deucher@amd.com>
>> Cc: amd-gfx@lists.freedesktop.org
>> Subject: Re: [PATCH] drm/amdgpu: don't skip runtime pm get on A+A config
>>
>> You are looking at outdated code, that stuff is gone by now.
>> amd-staging-drm-next probably needs a rebase.
> Yep, I can see it in the vanilla kernel.
> The patch is acked-by: Evan Quan <evan.quan@amd.com>

Thanks.

Alex any objections that I push this to drm-misc-next? It was found
while working on changes already upstream in that function and would
conflict if we push it through amd-staging-drm-next.

Regards,
Christian.

>
> BR
> Evan
>> And this code was what the check was initially good for. Just skipping t=
he PM
>> stuff as well on A+A was unintentionally.
>>
>> Regards,
>> Christian.
>>
>> Am 07.12.21 um 02:58 schrieb Quan, Evan:
>>> [AMD Official Use Only]
>>>
>>> It seems more jobs(below) other than bumping the runpm counter are
>> performed.
>>> Are they desired also?
>>>
>>>      r =3D __dma_resv_make_exclusive(bo->tbo.base.resv);
>>>      if (r)
>>>              goto out;
>>>
>>>      bo->prime_shared_count++;
>>>
>>> BR
>>> Evan
>>>> -----Original Message-----
>>>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
>>>> Christian K=F6nig
>>>> Sent: Monday, December 6, 2021 4:46 PM
>>>> To: Deucher, Alexander <Alexander.Deucher@amd.com>
>>>> Cc: amd-gfx@lists.freedesktop.org
>>>> Subject: [PATCH] drm/amdgpu: don't skip runtime pm get on A+A config
>>>>
>>>> The runtime PM get was incorrectly added after the check.
>>>>
>>>> Signed-off-by: Christian K=F6nig <christian.koenig@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 3 ---
>>>>    1 file changed, 3 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>>>> index ae6ab93c868b..4896c876ffec 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>>>> @@ -61,9 +61,6 @@ static int amdgpu_dma_buf_attach(struct dma_buf
>>>> *dmabuf,
>>>>     if (pci_p2pdma_distance_many(adev->pdev, &attach->dev, 1, true)
>> <
>>>> 0)
>>>>             attach->peer2peer =3D false;
>>>>
>>>> -  if (attach->dev->driver =3D=3D adev->dev->driver)
>>>> -          return 0;
>>>> -
>>>>     r =3D pm_runtime_get_sync(adev_to_drm(adev)->dev);
>>>>     if (r < 0)
>>>>             goto out;
>>>> --
>>>> 2.25.1


--_000_BL1PR12MB51442E00587BEC974E2D77C1F7709BL1PR12MB5144namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
No objections from me.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Christian K=F6nig &lt=
;ckoenig.leichtzumerken@gmail.com&gt;<br>
<b>Sent:</b> Thursday, December 9, 2021 10:34 AM<br>
<b>To:</b> Quan, Evan &lt;Evan.Quan@amd.com&gt;; Deucher, Alexander &lt;Ale=
xander.Deucher@amd.com&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: don't skip runtime pm get on A+A co=
nfig</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Am 07.12.21 um 08:40 schrieb Quan, Evan:<br>
&gt; [AMD Official Use Only]<br>
&gt;&gt; -----Original Message-----<br>
&gt;&gt; From: Christian K=F6nig &lt;ckoenig.leichtzumerken@gmail.com&gt;<b=
r>
&gt;&gt; Sent: Tuesday, December 7, 2021 3:03 PM<br>
&gt;&gt; To: Quan, Evan &lt;Evan.Quan@amd.com&gt;; Deucher, Alexander<br>
&gt;&gt; &lt;Alexander.Deucher@amd.com&gt;<br>
&gt;&gt; Cc: amd-gfx@lists.freedesktop.org<br>
&gt;&gt; Subject: Re: [PATCH] drm/amdgpu: don't skip runtime pm get on A+A =
config<br>
&gt;&gt;<br>
&gt;&gt; You are looking at outdated code, that stuff is gone by now.<br>
&gt;&gt; amd-staging-drm-next probably needs a rebase.<br>
&gt; Yep, I can see it in the vanilla kernel.<br>
&gt; The patch is acked-by: Evan Quan &lt;evan.quan@amd.com&gt;<br>
<br>
Thanks.<br>
<br>
Alex any objections that I push this to drm-misc-next? It was found <br>
while working on changes already upstream in that function and would <br>
conflict if we push it through amd-staging-drm-next.<br>
<br>
Regards,<br>
Christian.<br>
<br>
&gt;<br>
&gt; BR<br>
&gt; Evan<br>
&gt;&gt; And this code was what the check was initially good for. Just skip=
ping the PM<br>
&gt;&gt; stuff as well on A+A was unintentionally.<br>
&gt;&gt;<br>
&gt;&gt; Regards,<br>
&gt;&gt; Christian.<br>
&gt;&gt;<br>
&gt;&gt; Am 07.12.21 um 02:58 schrieb Quan, Evan:<br>
&gt;&gt;&gt; [AMD Official Use Only]<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; It seems more jobs(below) other than bumping the runpm counter=
 are<br>
&gt;&gt; performed.<br>
&gt;&gt;&gt; Are they desired also?<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D __dma_resv_make_exclusive(=
bo-&gt;tbo.base.resv);<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; goto out;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bo-&gt;prime_shared_count++;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; BR<br>
&gt;&gt;&gt; Evan<br>
&gt;&gt;&gt;&gt; -----Original Message-----<br>
&gt;&gt;&gt;&gt; From: amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt=
; On Behalf Of<br>
&gt;&gt;&gt;&gt; Christian K=F6nig<br>
&gt;&gt;&gt;&gt; Sent: Monday, December 6, 2021 4:46 PM<br>
&gt;&gt;&gt;&gt; To: Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<b=
r>
&gt;&gt;&gt;&gt; Cc: amd-gfx@lists.freedesktop.org<br>
&gt;&gt;&gt;&gt; Subject: [PATCH] drm/amdgpu: don't skip runtime pm get on =
A+A config<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; The runtime PM get was incorrectly added after the check.<=
br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Signed-off-by: Christian K=F6nig &lt;christian.koenig@amd.=
com&gt;<br>
&gt;&gt;&gt;&gt; ---<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_dma_bu=
f.c | 3 ---<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; 1 file changed, 3 deletions(-)<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c<b=
r>
&gt;&gt;&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c<br>
&gt;&gt;&gt;&gt; index ae6ab93c868b..4896c876ffec 100644<br>
&gt;&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c<br>
&gt;&gt;&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c<br>
&gt;&gt;&gt;&gt; @@ -61,9 +61,6 @@ static int amdgpu_dma_buf_attach(struct =
dma_buf<br>
&gt;&gt;&gt;&gt; *dmabuf,<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; if (pci_p2pdma_distance_many(adev-=
&gt;pdev, &amp;attach-&gt;dev, 1, true)<br>
&gt;&gt; &lt;<br>
&gt;&gt;&gt;&gt; 0)<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; attach-&gt;peer2peer =3D false;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; -&nbsp; if (attach-&gt;dev-&gt;driver =3D=3D adev-&gt;dev-=
&gt;driver)<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; re=
turn 0;<br>
&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; r =3D pm_runtime_get_sync(adev_to_=
drm(adev)-&gt;dev);<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; if (r &lt; 0)<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; goto out;<br>
&gt;&gt;&gt;&gt; --<br>
&gt;&gt;&gt;&gt; 2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB51442E00587BEC974E2D77C1F7709BL1PR12MB5144namp_--
