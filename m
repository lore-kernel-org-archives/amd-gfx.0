Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2D3DC28CF5
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jan 2022 12:57:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7828D10E926;
	Wed, 26 Jan 2022 12:57:13 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37F3910E926
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jan 2022 12:57:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gFY9iEYWDobED9PYWOkWM8nKHO+nzjxJXNz1i/d1zziizAfKSdfn79aI5ixiUWrC4r0w2YKO4w/ZL2J5j4io+MTWkenJiWC6S6gG6EegSBgbrcOgQRx4jmC7uGZgviaC186Jb7wUc8DYln1zwq9gOy6by4O6rkvdYBfIpIDyIo9Y3XSOtxk3/oyPYuwwXPqyJS7sNjwkhip8sFUnGXds+13JzkWfBdxsodcX+24ars46zRnu+QE/UUXAX3R3SKa64wzTwn8J/k7nLr2T9pUE6CwoOgPwVEYLy1nvQD7FCjHKaXkiRT3Dm2wltkK2B/u6NEa1v6kF7uxIvqNkp3Fn4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mNPo3/+xgkQGeQx9t5Ts4+G0LV1PyllEyMUDP3fuoIs=;
 b=CuGesI7joBGK5IpjGcP3LYhachuIyLtOIW4c3H8boVZ54FMmF4l6eQY2HZFS0fPCR5umcJcfXO7yeEmJWX++I2b0DPqbLrGF8YZV6nXB9HuXmlTucJuhevi5H3P9wAm+rm3/Un7xcmPHmOvPmuzx1ge/f35rfyMnvSKk0VTaYBGNA/8EnBVs+38fxurt3kuREqQjXdR1cuvI9m6uglYXsCwVy6M+SIKsXRQi4RoI84yQils5t2en5yh2jaWAPeRlP+Ip30+QMb4vgMhxR3jmbBPFQwFqTv/+aCIjiYNQRDluDsyDRMgfD10P0l6SJFn/qoH0mFapB3eLoBNQ2Upr6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mNPo3/+xgkQGeQx9t5Ts4+G0LV1PyllEyMUDP3fuoIs=;
 b=O2GVB8yYtRE88xWOqv1pW//h8xtYdkEHnWUChiWq5auhrpHaqwwQBMzy69PEeckmlN3Dp2974rE0GHUawC3aYbT+mnYOpmysGrfLCXpmi/CBqqxe3J7dWij8OzN1BAXjdsgHOuHU2v0SOvKRrd05oAWQ700nAk0THV3M7Z6JRp4=
Received: from DM6PR12MB3547.namprd12.prod.outlook.com (2603:10b6:5:18a::20)
 by BYAPR12MB3189.namprd12.prod.outlook.com (2603:10b6:a03:134::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12; Wed, 26 Jan
 2022 12:57:06 +0000
Received: from DM6PR12MB3547.namprd12.prod.outlook.com
 ([fe80::d4e4:8282:5f20:c812]) by DM6PR12MB3547.namprd12.prod.outlook.com
 ([fe80::d4e4:8282:5f20:c812%4]) with mapi id 15.20.4909.017; Wed, 26 Jan 2022
 12:57:06 +0000
From: "StDenis, Tom" <Tom.StDenis@amd.com>
To: "Tuikov, Luben" <Luben.Tuikov@amd.com>, =?iso-8859-1?Q?Christian_K=F6nig?=
 <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: add sysfs files for XGMI segment size and
 physical node id
Thread-Topic: [PATCH 2/2] drm/amdgpu: add sysfs files for XGMI segment size
 and physical node id
Thread-Index: AQHYEqwo8U8vCGXuC0mQQ0X1Xi2+76x1QoqAgAAAcLM=
Date: Wed, 26 Jan 2022 12:57:06 +0000
Message-ID: <DM6PR12MB3547491395B2ABB676CC9000F7209@DM6PR12MB3547.namprd12.prod.outlook.com>
References: <20220126115917.60308-1-christian.koenig@amd.com>
 <20220126115917.60308-2-christian.koenig@amd.com>
 <fbf698cf-594a-2980-814f-dc66e576ad62@amd.com>
In-Reply-To: <fbf698cf-594a-2980-814f-dc66e576ad62@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-26T12:57:06.185Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: 59445668-b1c2-6dbb-fdb5-15099c5e7213
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 31aaf0de-6dba-452d-2009-08d9e0cb5b7c
x-ms-traffictypediagnostic: BYAPR12MB3189:EE_
x-microsoft-antispam-prvs: <BYAPR12MB318931699E905F692DA58DF0F7209@BYAPR12MB3189.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zCVXWSEhiLz7bqHhEIUX0SVU1LbV4IpORlnTSlARSqbFyl+LuWoatdSJOFL+IFHE8P2gH4c5aDjaKOjOkH4AOhGKrgnofQ6vSI5U4cqF7HlacUWTNUCYbq9SSHbieZeLVH8F3tNxmdmPQCeu4lb/wX2yKCncHf9uZ0yfLuu7z5YYKJPXxNg+9mjrLRStUXp8tfKEUcXxx3wmYdLYav842JlSsKehwKJwZKbecvYTqDrVunESR/SegWmKIEHZ28b1SJp8KxQ1WetTmBs0axcimMlWfouebDQxEN1BUcKo6co/TBv0z4eUZHVRaq2zaRJmgiTuK9XEyYZ7iYTan4o4bWrJfuX7rgZi36lwiYVRcuPPi1R0K6JPrfz1Kpkvjcg6SFcTh3k1JLOBCE4zCQn1AX9C1VrqupeVQ1uba5gjvXri114dSCi1rKO5N6kCMCPFnqCYOB63kwcGaUUyNnWRG3VjTdt5v76rphR0Rr9O4Q8p4Bcwqgv6SQ5xiKFIfBTdF1x/rGUJPs88l+SGnPhbY+m/SKkd5oSGR2LzxWH2r4v0sWv4RpPc8Lc1VoK5YSOq6o9/VX0EqBzY4YdO9naIsQlX3QAMu4UXI37Pac7G550qiomUE3HLRGvVOxBbqXrrHoyzqEe7O8LnixE68IaCWVwoiuadFPhR6aSiNWZ3Aisdx8ho7x3g6TsW98Am5l10tM9pvmxzLWR17nBCdhNlQg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3547.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(33656002)(2906002)(508600001)(110136005)(6506007)(76116006)(64756008)(7696005)(8936002)(91956017)(38100700002)(86362001)(66446008)(52536014)(66946007)(316002)(66476007)(122000001)(8676002)(66556008)(71200400001)(38070700005)(55016003)(186003)(4326008)(9686003)(53546011)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?wB8WiGI8adphRyM8rqh5pP34mM7ti586X1qPSsco0U/lczBTk4Ay88lSFU?=
 =?iso-8859-1?Q?rSPuuUc03bbxcLc/NVMjJeVb33IK6COsOMUBRVf4AFlDVuw9FvmPhjtAdQ?=
 =?iso-8859-1?Q?Y7H/IextgDfKhvNZRSA+H2l1NC51BC/C532V6boKVudErKd8C6BugySPHi?=
 =?iso-8859-1?Q?rP5S65QUNViE1BOq4Wz5T0i/IlD00tsutXqGd1/cdupKyEFQ0UvUMigb5z?=
 =?iso-8859-1?Q?oDkq27netsdhMcD9pCZXkhZU9otCc5qD3qVfpX8y2w+TWYr+UYjz9JReoV?=
 =?iso-8859-1?Q?Xot/d1ceIuAbwqOiAJ92oK/H7ERVI/YnRE2D+808QP1GfGT8SMFFLRH7Al?=
 =?iso-8859-1?Q?hNEvvJWccsGMef5qnrLHr6pjc25ifRQWXlUBBlvw5KVDByFxn7aotQIJjj?=
 =?iso-8859-1?Q?pIjBfyStwMy3RH3J43a5YVrVr3sSA1K3OXXRwkQoAT68/dqOgscl/1A4GH?=
 =?iso-8859-1?Q?HdoMJJ73RMW59S+axPDjDZHTjT0U7MFoBL3nP8zBgdl6cMlNgAcyNI2Tf0?=
 =?iso-8859-1?Q?vs6vwAJnHtE6g3Ls/O2JfUluhzL0YeeILQg7bP+AwZ3K1WpQemk42ME3HU?=
 =?iso-8859-1?Q?jfMBbFPZBKroNY2aFc3zjeWuZ4a6CYY109zkefppGAEW/u7tQrRA2Zjm+o?=
 =?iso-8859-1?Q?d8e0HDxUfynZrcFmxx9MjGPlMm7mfeIkE/DRfCzqjdoYdDaootsmwvqU1g?=
 =?iso-8859-1?Q?ZfCtbvEYL4CK/oseqVWWJsmAueFX59aVMIAnSzblv3UspN8bu8pHSYo78F?=
 =?iso-8859-1?Q?9n+fj/XCftC9gJqY4OdKajpnl8hqacCql80btcqQE/DRxsrTZnExgH/tcn?=
 =?iso-8859-1?Q?PiS7mTajFN/nW+1CmodRXozgP4FzZ8HQGyc5KOgSnTVnXp107aATeK9Glz?=
 =?iso-8859-1?Q?rfMAT/G3y9wOoInrTcVkzEFo1n3Uj+AZ01IvbUaQPk5TPS6F5f21iyGGqD?=
 =?iso-8859-1?Q?5wvI0JyzMLId6qVV1cPkIPiMF93W3vZdEsQDZ7EM84tcXfEiqsxURykdL6?=
 =?iso-8859-1?Q?AG8JKkXNd8HJwVuwUH2stdnAqY7Cu0/4yhmObj2FJF2JCy5ZyzEz+Mj2/l?=
 =?iso-8859-1?Q?5K5l28BtlJpXStFevbIXYagya/hVImHq1tLEQ/yn7NqEfeTkGYQu6Q1vKm?=
 =?iso-8859-1?Q?w1v8x6UuID7pxzF7eXzq+pckV7tVTtQGp95TepkS+miOlKA+mAwN64Cpb9?=
 =?iso-8859-1?Q?APC1PZQUEoHLo5+ZZJ71DrXkA+fFZ6fBnI0ktYjTR6I7gnWjQF/2fRwof8?=
 =?iso-8859-1?Q?0hngr6TEC2tTWRboCxTyGQRm7yEWCeE7nPrEpIjHevtWWtFKbpQYG7LBa/?=
 =?iso-8859-1?Q?TgGWu2LcUBj0nzS1jHJV9vmpuJkliU+ib/sVCJ/Trtr8dl1n13Iej4/BeF?=
 =?iso-8859-1?Q?S/5wdxnfULUvWk2SMBQ+OeT/ihUCCULpVZZuX3elwgykMsqY2QAA7H+5ZS?=
 =?iso-8859-1?Q?eXcb85Z9llN9b38VrWpAaO5ntxVwE2XQLyv+h8JZBPxC2LVWp6j5sYlBUO?=
 =?iso-8859-1?Q?UWG6DB4wfA1qpjMP9nBpE9WY6Txw3rolmmr0xYHNe5IluTJ3wUL/KNZHXy?=
 =?iso-8859-1?Q?0IJ3KfyCkGXYTmujnqVe+YifT7KPnBqjvVMXkRcef+0EXm1fgPy6IMUcJA?=
 =?iso-8859-1?Q?1nczD1HGw4c4yOI2QpXaZg68Ck6ITuo2tr/mI3RwtMl/LqzFd0Rd0GOSkS?=
 =?iso-8859-1?Q?ndGRWE75zkSAYE7CzFAwO51o6+u5MrhvaMi0+L+Nba6XWG5gu8zlJwDuwm?=
 =?iso-8859-1?Q?EQzQF1ccRyP+CLVE99jtUci1Y=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3547.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31aaf0de-6dba-452d-2009-08d9e0cb5b7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2022 12:57:06.6386 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H8M9Y0cVkGtNTEE4E/GcBxSjzc3CVHbdPQmyOC+CR2rVOSOZIXFL87hYnu9zZYcCzUtaqKWuNSSq+2n6HWle0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3189
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

[AMD Official Use Only]

Sadly I don't control any XGMI hosts to try it out.  So if they pick it up =
in their builds I can but otherwise we'll have to wait.

Tom

________________________________________
From: Tuikov, Luben <Luben.Tuikov@amd.com>
Sent: Wednesday, January 26, 2022 07:55
To: Christian K=F6nig; StDenis, Tom
Cc: amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 2/2] drm/amdgpu: add sysfs files for XGMI segment size =
and physical node id

This seems reasonable. Hope it works out for umr.

Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>

Regards,
Luben

On 2022-01-26 06:59, Christian K=F6nig wrote:
> umr needs that to correctly calculate the VRAM base address
> inside the MC address space.
>
> Only compile tested!
>
> Signed-off-by: Christian K=F6nig <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 34 ++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_xgmi.c
> index 68509f619ba3..21a5d07a1abf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> @@ -252,6 +252,26 @@ static ssize_t amdgpu_xgmi_show_device_id(struct dev=
ice *dev,
>
>  }
>
> +static ssize_t amdgpu_xgmi_show_node_segment_size(struct device *dev,
> +                                               struct device_attribute *=
attr,
> +                                               char *buf)
> +{
> +     struct drm_device *ddev =3D dev_get_drvdata(dev);
> +     struct amdgpu_device *adev =3D drm_to_adev(ddev);
> +
> +     return sysfs_emit(buf, "%llu\n", adev->gmc.xgmi.node_segment_size);
> +}
> +
> +static ssize_t amdgpu_xgmi_show_physical_node_id(struct device *dev,
> +                                              struct device_attribute *a=
ttr,
> +                                              char *buf)
> +{
> +     struct drm_device *ddev =3D dev_get_drvdata(dev);
> +     struct amdgpu_device *adev =3D drm_to_adev(ddev);
> +
> +     return sysfs_emit(buf, "%u\n", adev->gmc.xgmi.physical_node_id);
> +}
> +
>  #define AMDGPU_XGMI_SET_FICAA(o)     ((o) | 0x456801)
>  static ssize_t amdgpu_xgmi_show_error(struct device *dev,
>                                     struct device_attribute *attr,
> @@ -287,6 +307,10 @@ static ssize_t amdgpu_xgmi_show_error(struct device =
*dev,
>
>
>  static DEVICE_ATTR(xgmi_device_id, S_IRUGO, amdgpu_xgmi_show_device_id, =
NULL);
> +static DEVICE_ATTR(xgmi_node_segment_size, S_IRUGO,
> +                amdgpu_xgmi_show_node_segment_size, NULL);
> +static DEVICE_ATTR(xgmi_physical_node_id, S_IRUGO,
> +                amdgpu_xgmi_show_physical_node_id, NULL);
>  static DEVICE_ATTR(xgmi_error, S_IRUGO, amdgpu_xgmi_show_error, NULL);
>
>  static void amdgpu_xgmi_sysfs_rem_dev_info(struct amdgpu_device *adev,
> @@ -295,6 +319,8 @@ static void amdgpu_xgmi_sysfs_rem_dev_info(struct amd=
gpu_device *adev,
>       char node[10];
>
>       device_remove_file(adev->dev, &dev_attr_xgmi_device_id);
> +     device_remove_file(adev->dev, &dev_attr_xgmi_node_segment_size);
> +     device_remove_file(adev->dev, &dev_attr_xgmi_physical_node_id);
>       device_remove_file(adev->dev, &dev_attr_xgmi_error);
>
>       if (hive->kobj.parent !=3D (&adev->dev->kobj))
> @@ -318,6 +344,14 @@ static int amdgpu_xgmi_sysfs_add_dev_info(struct amd=
gpu_device *adev,
>       if (r)
>               goto error;
>
> +     r =3D device_create_file(adev->dev, &dev_attr_xgmi_node_segment_siz=
e);
> +     if (r)
> +             goto error;
> +
> +     r =3D device_create_file(adev->dev, &dev_attr_xgmi_physical_node_id=
);
> +     if (r)
> +             goto error;
> +
>       /* Create sysfs link to hive info folder on the first device */
>       if (hive->kobj.parent !=3D (&adev->dev->kobj)) {
>               r =3D sysfs_create_link(&adev->dev->kobj, &hive->kobj,

Regards,
--
Luben

