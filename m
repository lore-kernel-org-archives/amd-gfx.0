Return-Path: <SRS0=SWRn=ML=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB624C07E95
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jul 2021 16:02:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A07961357
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jul 2021 16:02:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A07961357
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF79F898FA;
	Mon, 19 Jul 2021 16:02:49 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2071.outbound.protection.outlook.com [40.107.102.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E41C893A2
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jul 2021 16:02:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eBDhCbcbANDvklRfsE0Y+4RhrVhjntUAf8VB8ZIQ2Rc/8B1zWBYPgcmmKIXyhYUn+qXu5y8mVeduBUWZP8HxptASpDZcbucVCl33R9uzKiIPk3uak2W8cdy+X2dzu0PRbHEfYBdUWCiciDchTnyiYrlFSeH3qf3ZfQwqdYblVIrKFp78kJqn3KqE/jhn0HpLboOQ27GoH8f7Kc2odqKp/DSo83sedyTG2w3/lMK075eEEJ0tRbN9gcrtfmsNgs3scz0T6AajTJgWaWKVTDWF8XpglWIbET5mAkg74FTCXdrQKbf233O7oDnPbeu/Kkha5LJJFPfufh4TAcJ1eqKtCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XHSi2Y2Cq9ljUy0H8691feATXEiqWAkpclabysuStMg=;
 b=HNH5VzV6X/VzVZAW9NO2SV3UniG+yClA0MKkJ6/YrzJfPe6yIx1yHtAGvvYI/TocwKv7fGn7TrGuwIPQdl4RNZRjnUkEUSMN/GBvvODwLHgz1mX7qB8n3I+4T7iXHXtMAJwOSc198lAxQQMZr8/XeKta7Dlzw8PB4dPKQ6mmrH2tBOO1C8W62R3eeU6RPv1EefB4HBRytup/seNeivcSHt0p/N1axBY8YcNgrnOs/rMy0DvPpBPXvR1Yn68nRGrNm2vDlUJMiHnarrbwND+mriARkoRr26/8N5M51aEkSkjf0vg1APUBdjWiLoYPWTnOUARhUDQCFwIQhsChg3zzAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XHSi2Y2Cq9ljUy0H8691feATXEiqWAkpclabysuStMg=;
 b=l+HuexHDTxCipJpjLj/815kVMJEswpK5kGXWV0FLNdMHvwNi+yOuOD/PD1ZhuK8VVb5J1slsqxVe0VH69SX8+KcNSqQdL5V+Oom/lenYj6S/G6DaNrBJkDL5v7+Bk7e/yj4V1pG5AQKIj1UtnFdZyvCscFaM+O1q5jO9Vufyrmg=
Received: from DM5PR12MB4680.namprd12.prod.outlook.com (2603:10b6:4:a6::33) by
 DM6PR12MB4957.namprd12.prod.outlook.com (2603:10b6:5:20d::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.21; Mon, 19 Jul 2021 16:02:46 +0000
Received: from DM5PR12MB4680.namprd12.prod.outlook.com
 ([fe80::1d06:dcde:55f9:3eb7]) by DM5PR12MB4680.namprd12.prod.outlook.com
 ([fe80::1d06:dcde:55f9:3eb7%7]) with mapi id 15.20.4331.032; Mon, 19 Jul 2021
 16:02:46 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/3] drm/amdkfd: report xgmi bandwidth between direct
 peers to the kfd
Thread-Topic: [PATCH 2/3] drm/amdkfd: report xgmi bandwidth between direct
 peers to the kfd
Thread-Index: AQHXemGzV9RvInrj80ePyyv8CyogaqtGqXiAgAPNahA=
Date: Mon, 19 Jul 2021 16:02:46 +0000
Message-ID: <DM5PR12MB4680A83D050640E9B6B520E385E19@DM5PR12MB4680.namprd12.prod.outlook.com>
References: <20210716164312.896939-1-jonathan.kim@amd.com>
 <20210716164312.896939-2-jonathan.kim@amd.com>
 <c7b3252f-ab9d-acde-aed8-0ae23951e6c0@amd.com>
In-Reply-To: <c7b3252f-ab9d-acde-aed8-0ae23951e6c0@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=8eba22ca-2380-470e-bdf4-f1c38dbb46f1;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-07-19T15:50:39Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: be111e74-fd15-4d8f-f501-08d94acea669
x-ms-traffictypediagnostic: DM6PR12MB4957:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4957167F40A9EC1A7302C57585E19@DM6PR12MB4957.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: px7QGm4XFyPxYMe0jgNq9eRTXKhMB8XeHaqEBbzq1w01g/NNEbSYYtrExaXfCCdB9FEjrSnA3+eL0y+oXCwoar734RmHiqMqvOKsXwRRIGj4e1l4xhrJkqlvBjJSq1QPqpcWcGnZi4oXFE1zR0KExDGjJzH7A4Eq2N4dQW/nGVv2QaJ1NhoXe7FMTfRyVqmsLOSiH8y5ON7oAo611eqNu5gq2WiDEzm1xWAZ9IKoCc9YlcSGMghP+jxbTqqohOKmbOC0k9g0mLQ0VyDCzNygAztA688HUXPsp46mLplD6SS8BWasA0i9FZL7cD1/dihXmoZ2FSqgtAwy+/gNfSUIdrBVEpPoSn7uIcaalZWHl9n1/JF1fX2eD1e7byMaL9SyKmeFjpxWLCGp/JHmYLPNjSXgntjcnjIzbZCX+atYlErEvUETXindRxn/MTZQyXZuYptcc96PW0qgWHMhagJbr/McD6nBsk27qNN9ACx0X0wX1XLbfuWo5rbHLR3ruDKKOelhqVV1+iXatCsLxELoniIAWOsaMkewZLXaqnuVnisYxmOfQM2Ndwdy+6pdhRIQmVu35/wcNK/VUaANanqgZRWh2TLyQylr3G3yWTzbq6dyyAM8GyV1IpwMgJiWiJkpRHF+m6BMrrU+b/S86FJfmTjfuIm6HVjZBjVivwZ1wopVrU7HGTZ5kJODd0Anqh4hJM0ifVWoKJLuPyvd/tGWUQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB4680.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2906002)(33656002)(8936002)(186003)(110136005)(9686003)(316002)(5660300002)(83380400001)(86362001)(66476007)(66446008)(76116006)(66946007)(66556008)(64756008)(52536014)(55016002)(6506007)(7696005)(53546011)(508600001)(71200400001)(122000001)(38100700002)(8676002)(38070700004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aERrbmNrOGxuc0RiNEZlLzF6TU9FWGUwR2lBU3ZTVHNoSWV0ODRFTWxWdTZV?=
 =?utf-8?B?VWRrcFZxVUJsRmtnTkw3aDU1a2p5dXd3Zk1WaFBBOWpvT01EcnZNcFEyRVB5?=
 =?utf-8?B?M2FnNlhwQUIvT0xScG1OWUZzZ2lvUmd6WHBjNHZ2NHlyakdXNlR4azVCM1Zt?=
 =?utf-8?B?c0FiUHhUVlJpdk9EdEJkTXZhUUt0MkllMEVSRkpYRWNveTdEMlVJUFRzbnQ4?=
 =?utf-8?B?U2tUTnA5N2ZnQVB2aEhEYkZKV2t0Skd6UzkzcE9FSHRZRXdsZlRkZzdpalhD?=
 =?utf-8?B?d2l4azR1eWJzYkZDVjl2VzZPRkhuZnpWc1FnZ09pa2NlTWJrNlZQcXNKTURX?=
 =?utf-8?B?d3VpbHdOVVE3QndtT0xMUVB3bnVEOS9kbVFGZTcyN0ZEcElHaUpNN2UzWDI1?=
 =?utf-8?B?TExaUUJab0t6WGtCMEZmdGJ1REpZUCtmWWhaNTNMUHlxZm9yUzBDdG9EdndE?=
 =?utf-8?B?d0ROeWowamY1dkc3RGYvME83MjlFOGdOZjlRc1NtKzhkelpBTkt0V0NDTkJ0?=
 =?utf-8?B?cUhabkI3dUFxMHk4Q3dBNllyVHVQdnBzRFdneExkS3N0c1FtSEpzRkRCSEtz?=
 =?utf-8?B?YzBobFpBcENRNldmVmVGY2ZpdkNxTWVCVnlVcG5OK2NHaWNPaTNyaSswWnR2?=
 =?utf-8?B?c0hDUWtmM1hZVmNtbU8vWllnUEVqZUFJTGJwTWJHdEJUSjVROWo1UkJLUkxx?=
 =?utf-8?B?VCsyL3JnbHdGcklUdCtWaDRUTzJ6SU9BNHNoWm5qS291OGhjZWdHa2R1VlZz?=
 =?utf-8?B?MXlXQ0pYazM4Y1BEeFVYUjJGNWZvWi9yMW9oekN6bHNRcGJpQlFWTWZnSkVP?=
 =?utf-8?B?Z3FmTyt4MmtJTG5EZWpnL05TQkx0RTh4NzFyWFRabGJ4ejlTNTY0OFZvMWVu?=
 =?utf-8?B?TkJURE9KdGxhSk8wOUlndlVVeFBMRE9zWDdxdzZhVmZ2WlpnMXM4K2hVN0Fw?=
 =?utf-8?B?L3Z4SEwwcjM3N3AvRjJwKzFtUldVa3VkTmdhWjdwYWNsZHQzMVJrbldDVG5r?=
 =?utf-8?B?SUZYV3Y5L3dqczRGaVFQSDQ3cTZrY1NmNk1UanM5anRzOTJMb3VqbUFZNGxm?=
 =?utf-8?B?NGFyN3k1WlVjanNlVWMzWXZ1M1lBdTBobU4xa2RhNjBVYlh5cmtrZ1EwMEJB?=
 =?utf-8?B?N2Z0RTVYeC80OUM2ZGFJWlFHM1ZzV1ppSkdDV21GWlIxTHhnK044azdnanNO?=
 =?utf-8?B?amtDSHMxUXpETnpFcDRZYVdaNFZRdzBFTTdkODVWL3NtZ3AyRFF4VExwbE4v?=
 =?utf-8?B?YmRMLzFBUE5CaFlxQXRXNUhwU0JBOERoaU54d2JJUGVTd2ZvUHJ2bnpxSEZV?=
 =?utf-8?B?Wis0UFFWejYwL2FWSnBVUkhEQU1adkQ1TVlaaW0xbnMwanhZLzdFNjhzclZH?=
 =?utf-8?B?L2lONFA3c1JDMUlGVmhmVFkvSzFRV1FwWEdZVW9mZ2hRZGNkRjRKV0pnWTAx?=
 =?utf-8?B?M3pidE93S1BmZTN6WlJ4ZVpFVTRMVFlCcStNbWJKRVlZUFd2eXFQVVdmMzFD?=
 =?utf-8?B?RWlsc0FNRGt6eEdidnR3T1UzR1R1N3VDNy9raERCWUx3alRVT2hqaVVwS0Vp?=
 =?utf-8?B?cXBFNGVEcXhTdzF1U2VMYk5KRUdiMUpkOWZUOFBhLzUvZXN3VUZMNmY5Z05M?=
 =?utf-8?B?emFxR2lDQ0JrZ1R6SXdiMFVSY0M0QUJPcW5lOUY4ckxhdmk3MWtWN3FVQ0l1?=
 =?utf-8?B?bGdGa0gxTWRETXhxUUdqZk1TQUZ1Uit0UnNHTjZIRmgreUVZWmdaNHhMR0Nj?=
 =?utf-8?B?SDZjZ2tlZEtjbWY4Nms2SEJ2UGhObW8yM2RMZW9mYmdUMTVCMjBYTGtuN2Yx?=
 =?utf-8?B?bFBhSHV2dmRJOFJyVzlYUlY4Ui9KRmtRckhhTEhaRHA4bzlkUko4TjFwSXdW?=
 =?utf-8?Q?aE9hJwoCzFCeT?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB4680.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be111e74-fd15-4d8f-f501-08d94acea669
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2021 16:02:46.4576 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J/hh5XKFRMDwPdKpEhSUkZIDS6c83SqVwxn7sc0/AALDlXnjpb2xuiQE35F816kc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4957
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

> -----Original Message-----
> From: Kuehling, Felix <Felix.Kuehling@amd.com>
> Sent: Saturday, July 17, 2021 1:47 AM
> To: Kim, Jonathan <Jonathan.Kim@amd.com>; amd-
> gfx@lists.freedesktop.org
> Subject: Re: [PATCH 2/3] drm/amdkfd: report xgmi bandwidth between
> direct peers to the kfd
>
> Am 2021-07-16 um 12:43 p.m. schrieb Jonathan Kim:
> > Report the min/max bandwidth in megabytes to the kfd for direct xgmi
> > connections only.
>
> By "direct XGMI connections", you mean this doesn't work for links with
> more than one hop? Will that spew out DRM_ERROR messages for such links?
> Then it's probably better to downgrade that to an INFO.

No DRM_ERROR only happens if psp fails on invoke.
I've added footnotes to the description and code to clear this up.
Non-adjacent peers return num_links as 0 since indirect route is unknown and linkage is asymmetrical.

>
>
> >
> > v2: change reporting from num links to bandwidth
> >
> > Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
>
> This patch is OK to provide bandwidth information on Aldebaran. What can
> we do on older GPUs? Can we assume num_links = 1? Or maybe have some
> hard-coded numbers depending on the number of nodes in the hive?

We could assume num_links = 1 but that wouldn't represent certain non-Aldebaran setups well.
For non-Aldebaran min/max bandwidth, we may be able to get away with setting non-zero values on non-adjacent peers since setup is symmetrical to date but that may raise questions on why Aldebaran indirect min/max-bandwidth is 0.  For consistency, we'd have to use num_hops then to check directness.
Maybe it's worth making a bid to the FW team to support all other chips moving forward  ...

Thanks,

Jon

>
> Either way, patch 1 and 2 are
>
> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
>
>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 23
> > ++++++++++++++++++++++
> drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  1 +
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c   | 12 +++++++++++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h   |  2 ++
> >  drivers/gpu/drm/amd/amdkfd/kfd_crat.c      | 12 +++++++++++
> >  5 files changed, 50 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> > index bfab2f9fdd17..3978578a1c49 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> > @@ -553,6 +553,29 @@ uint8_t
> amdgpu_amdkfd_get_xgmi_hops_count(struct kgd_dev *dst, struct kgd_dev
> *s
> >     return  (uint8_t)ret;
> >  }
> >
> > +int amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(struct kgd_dev *dst,
> > +struct kgd_dev *src, bool is_min) {
> > +   struct amdgpu_device *adev = (struct amdgpu_device *)dst,
> *peer_adev;
> > +   int num_links;
> > +
> > +   if (adev->asic_type != CHIP_ALDEBARAN)
> > +           return 0;
> > +
> > +   if (src)
> > +           peer_adev = (struct amdgpu_device *)src;
> > +
> > +   num_links = is_min ? 1 : amdgpu_xgmi_get_num_links(adev,
> peer_adev);
> > +   if (num_links < 0) {
> > +           DRM_ERROR("amdgpu: failed to get xgmi num links between
> node %d and %d. ret = %d\n",
> > +                   adev->gmc.xgmi.physical_node_id,
> > +                   peer_adev->gmc.xgmi.physical_node_id, num_links);
> > +           num_links = 0;
> > +   }
> > +
> > +   /* Aldebaran xGMI DPM is defeatured so assume x16 x 25Gbps for
> bandwidth. */
> > +   return (num_links * 16 * 25000)/BITS_PER_BYTE; }
> > +
> >  uint64_t amdgpu_amdkfd_get_mmio_remap_phys_addr(struct kgd_dev
> *kgd)
> > {
> >     struct amdgpu_device *adev = (struct amdgpu_device *)kgd; diff --git
> > a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> > index 81264517d532..e12fccb2d2c4 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> > @@ -226,6 +226,7 @@ uint32_t amdgpu_amdkfd_get_num_gws(struct
> kgd_dev
> > *kgd);  uint32_t amdgpu_amdkfd_get_asic_rev_id(struct kgd_dev *kgd);
> > int amdgpu_amdkfd_get_noretry(struct kgd_dev *kgd);  uint8_t
> > amdgpu_amdkfd_get_xgmi_hops_count(struct kgd_dev *dst, struct
> kgd_dev
> > *src);
> > +int amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(struct kgd_dev *dst,
> > +struct kgd_dev *src, bool is_min);
> >
> >  /* Read user wptr from a specified user address space with page fault
> >   * disabled. The memory must be pinned and mapped to the hardware
> > when diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> > index 8567d5d77346..258cf86b32f6 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> > @@ -486,6 +486,18 @@ int amdgpu_xgmi_get_hops_count(struct
> amdgpu_device *adev,
> >     return  -EINVAL;
> >  }
> >
> > +int amdgpu_xgmi_get_num_links(struct amdgpu_device *adev,
> > +           struct amdgpu_device *peer_adev)
> > +{
> > +   struct psp_xgmi_topology_info *top = &adev-
> >psp.xgmi_context.top_info;
> > +   int i;
> > +
> > +   for (i = 0 ; i < top->num_nodes; ++i)
> > +           if (top->nodes[i].node_id == peer_adev->gmc.xgmi.node_id)
> > +                   return top->nodes[i].num_links;
> > +   return  -EINVAL;
> > +}
> > +
> >  int amdgpu_xgmi_add_device(struct amdgpu_device *adev)  {
> >     struct psp_xgmi_topology_info *top_info; diff --git
> > a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
> > index 12969c0830d5..d2189bf7d428 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
> > @@ -59,6 +59,8 @@ int amdgpu_xgmi_remove_device(struct
> amdgpu_device
> > *adev);  int amdgpu_xgmi_set_pstate(struct amdgpu_device *adev, int
> > pstate);  int amdgpu_xgmi_get_hops_count(struct amdgpu_device *adev,
> >             struct amdgpu_device *peer_adev);
> > +int amdgpu_xgmi_get_num_links(struct amdgpu_device *adev,
> > +           struct amdgpu_device *peer_adev);
> >  uint64_t amdgpu_xgmi_get_relative_phy_addr(struct amdgpu_device
> *adev,
> >                                        uint64_t addr);
> >  static inline bool amdgpu_xgmi_same_hive(struct amdgpu_device *adev,
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> > b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> > index c6b02aee4993..40ce6239c813 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> > @@ -1989,6 +1989,13 @@ static int kfd_fill_gpu_direct_io_link_to_cpu(int
> *avail_size,
> >             sub_type_hdr->flags |=
> CRAT_IOLINK_FLAGS_BI_DIRECTIONAL;
> >             sub_type_hdr->io_interface_type =
> CRAT_IOLINK_TYPE_XGMI;
> >             sub_type_hdr->num_hops_xgmi = 1;
> > +           if (adev->asic_type == CHIP_ALDEBARAN) {
> > +                   sub_type_hdr->minimum_bandwidth_mbs =
> > +
>       amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(
> > +                                                   kdev->kgd, NULL,
> true);
> > +                   sub_type_hdr->maximum_bandwidth_mbs =
> > +                                   sub_type_hdr-
> >minimum_bandwidth_mbs;
> > +           }
> >     } else {
> >             sub_type_hdr->io_interface_type =
> CRAT_IOLINK_TYPE_PCIEXPRESS;
> >     }
> > @@ -2033,6 +2040,11 @@ static int kfd_fill_gpu_xgmi_link_to_gpu(int
> *avail_size,
> >     sub_type_hdr->proximity_domain_to = proximity_domain_to;
> >     sub_type_hdr->num_hops_xgmi =
> >             amdgpu_amdkfd_get_xgmi_hops_count(kdev->kgd,
> peer_kdev->kgd);
> > +   sub_type_hdr->maximum_bandwidth_mbs =
> > +           amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(kdev->kgd,
> peer_kdev->kgd, false);
> > +   sub_type_hdr->minimum_bandwidth_mbs = sub_type_hdr-
> >maximum_bandwidth_mbs ?
> > +           amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(kdev->kgd,
> NULL, true) : 0;
> > +
> >     return 0;
> >  }
> >
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
