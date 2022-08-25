Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDAE4C28D13
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Aug 2022 07:00:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7707CD8B6F;
	Thu, 25 Aug 2022 07:00:09 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5009ED8B34
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Aug 2022 06:59:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hcu2JtXMQP6vDkTaRMJ6HIU6TiKYy10YAO+3y0xvlkZK6J4Gg/GWFzFg6O1NJukFks6bCyI/GnbMbLXymkznByKG1FUjYXOVVGkXoSapW/qwC5Um7AIemFptlWxAGnizI2d72O5r+IpzNFsndMoeKwI8tjWdsunMXbvZGjbgIKe+iJTIF8YTWMmfphTcBFjCpKnaeUR0jJq3E/iURcuIXiNgmSKY7fLdXeFbNXwxNUkOqSi5TffoVEWKCVHuMZ1OHaufLd97EDrSYj5s5JPGl6Cqzovy7bPzNfIp6EFENNHvkvdYtqm0sDaI0gaMLqjAFKeVkBGeiVCj2zOQQKY01A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qoO6rSLxzHhMsgvX+CS3/EwFoL54Pg3DA29A/lnrNiQ=;
 b=IevHuLNUoTxpsZUqRt9yFnMFl6BwrYZNPXKNKKiYjTv1iQI3EAHoXbzsShi6eF+/aQ+pIQL44jwB9I6EP/Sti/4Up4oGJt4yCDMH5FSwSRtV6bjQL2d/gwSP71vzKTXL1moEC4xHrEcz+vryN/o7l6iGGZ19lsM4fEGNMEKznr6sMOR+U2yiXl9XSIn0+A5GhjNOR2p0N+VxOK3kYfWuRfnMsfVHqkNh/durBOQI3vE2S5uWLBKz0sB1I93BaRYDGugn8S3sxIkYUfNgJXfZ/pxmWfUlHMLBiuwTz0ls1b8t6hTGIMR5tYdKIQVqyz6CxgWl0AcYc1D/kgqWKOV/lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qoO6rSLxzHhMsgvX+CS3/EwFoL54Pg3DA29A/lnrNiQ=;
 b=V1kEBvFOkU1wwhJtcul8YynmBhk0L/XN/PVhs+BHBbr0401r+NVQUvO9L/1s2ExkcYRUpUeOahe8WqKdZodptmsoZoQwpAaM+R5U9U+P1HpGh1QVeWWVgnolT3uHTZW6iYhyIQ5N7BDhtnAHTB2zWWG6lGDjWE3H1dtL5NH7Gsc=
Received: from BL1PR12MB5237.namprd12.prod.outlook.com (2603:10b6:208:30b::18)
 by MW4PR12MB5644.namprd12.prod.outlook.com (2603:10b6:303:189::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 25 Aug
 2022 00:27:38 +0000
Received: from BL1PR12MB5237.namprd12.prod.outlook.com
 ([fe80::5576:6164:80cd:1f11]) by BL1PR12MB5237.namprd12.prod.outlook.com
 ([fe80::5576:6164:80cd:1f11%9]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 00:27:38 +0000
From: "Liu, Aaron" <Aaron.Liu@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: Fix isa version for the GC 10.3.7
Thread-Topic: [PATCH] drm/amdkfd: Fix isa version for the GC 10.3.7
Thread-Index: AQHYt4SIQE89o3rhGEaxEnyih/49da29/jyAgADCCnCAAACsoA==
Date: Thu, 25 Aug 2022 00:27:38 +0000
Message-ID: <BL1PR12MB52371CEB555CFEA6F53CB20BF0729@BL1PR12MB5237.namprd12.prod.outlook.com>
References: <20220824064048.2581639-1-Prike.Liang@amd.com>
 <DS7PR12MB6005164AE7FD86070B2E545DFB739@DS7PR12MB6005.namprd12.prod.outlook.com>
 <BL1PR12MB52378253F334F7CFC0BA71A1F0729@BL1PR12MB5237.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB52378253F334F7CFC0BA71A1F0729@BL1PR12MB5237.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-08-25T00:15:15Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=99420bb2-b49e-4600-8d74-1d73e2a752b9;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-08-25T00:27:34Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: c2dc5c4d-8d6b-4e5f-9db0-fe25c19bbf7a
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8dad0afe-bc32-48c8-d35c-08da86309d40
x-ms-traffictypediagnostic: MW4PR12MB5644:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I3cpOUERiK0i7yfhdQzHN7J7SFqL9kfxt/LqMNZLUPlfA+gUy7ZLNDu1wJy24Iw1oj9Siik5ieaGXO1Gp2YdmBPh2ZDYVwNWwWhTBe5lGTvo1wmqG+wwMHnne1o9pjgw6rDNwDj/tHty5apS8ZYZKON3HjaSENl2q6xHLv2G0V9OkUKti6UbJce67fwvX5O3cn1MoGGadtnWSG49LEhjD4kj16Ms9jh+dS5QlvF4UnUyacSnXo2PnFBz3z/w4CP73K5Wod7NNQzexMKrBWrHeHlJxI57+xdMkS4oVD19NTlbauyPbInyTIyGyCt+5czLkIdZn3ART0JfKS9BQnfTeglDc29IkNWO+9vppvTcyndqDTMfXKjiiREu8WOzSMI1t5giws+tWunrPzgdEvdMfIW3H3YLaUe9hwf7XWC/y6G31uTqJCfxZFB8tcH9k5mwXHxqjslWEEsUNz4G/bx32l3PPSdZQZTzqs5hcwJdfxbz+6JurPjawgkh5BXWzqQzlCn59rPyiFlG8G/6HHfluM2omFMYz7dT02EVqtt1SV9sENX7rdQCQYjBOlMxx+Fbkkzx8ankItXPPkIvx+UrI85nniSn//Udnc2Diqu+WHRH0LNDpPZq+CpLUXAaHINjHsBhOI5lXe0EkyujfPGPXqTAo60ZL5nc8sVc4CehycChk4JcBTd1QMtdkEbVY8+pCr7TsCtn7ArIdQ47ZK1dGTRjcC69ksRDjBvw1PvmvG3tSKLJL6OxIwlRsvRocj7GkZr784hM1uxr8tOB8xSOPA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5237.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(346002)(39860400002)(396003)(366004)(136003)(83380400001)(2906002)(2940100002)(53546011)(7696005)(9686003)(26005)(186003)(33656002)(6506007)(86362001)(38070700005)(55016003)(38100700002)(122000001)(54906003)(8936002)(52536014)(110136005)(5660300002)(41300700001)(316002)(66556008)(66946007)(76116006)(71200400001)(66476007)(64756008)(66446008)(478600001)(8676002)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TdnAZWJ51w4L4WtsoVC02649ezApvCk96vBb5l84Y7gnengaA0nUAsf3jeWu?=
 =?us-ascii?Q?uLOmgQ01DQL83vFRPPB6Gw4OgYOkn/bMSVP5pab6gwf4nlzlayPp5RstpRGB?=
 =?us-ascii?Q?Ox7UV1hvxFoXiJabNFZC3MJN9a8b0WSKeG/CVMCl/JTdxWuPedryl6Sayysm?=
 =?us-ascii?Q?COS666k6I8mRGjsfUwGT4fd1pkZPuz3Mvva8tzdBQVaGNo6o6rKFaIHI6rY9?=
 =?us-ascii?Q?r4T0Th5hS3vlyarwiNl9Tcr9JywOBrKNiJ/OaXsfQypLqem4qZ5fwlbAinc1?=
 =?us-ascii?Q?CHsjsGfh02QFw1EMFft0ZEKNKZEJg8d3iPqfxhCMEexIp6BXjqycjYPw/EMk?=
 =?us-ascii?Q?32g5mH4iR8OeNexSj8I++khUqDvqQ1vskSuZ1bgRRQjeKAr569RQO24BRBwP?=
 =?us-ascii?Q?8gtCm9MsK/ilFsdq3g8zGVUUpO1C0pNWXpvYKxAQ/VCZFOyqo3dTNS1Qi+qe?=
 =?us-ascii?Q?Tg/mM+ZI5rpZJQ2hyRGLl920QJsHtYyO1X0q52Nu8juQWMiUJk2+tlSdKosA?=
 =?us-ascii?Q?rMI2n9YHDERgScxl8gCCaJS6H5rN5JDlGmRQ3NXPPyemZAUBU2cFAkiZRyYW?=
 =?us-ascii?Q?rZF0gs/t7imuTGywNDoLurvuAQ5Y89fKzw+8Cai36dEmx+84x4/Ote8hlLEp?=
 =?us-ascii?Q?zShQ8KVJ26Myw0nlWP/z8DfEBSxFi6/AE73bhkYBr3yUS92455inj1p+zLfS?=
 =?us-ascii?Q?QX2s+vygq2FPoTBtwlwd4Iaeko48hqucI96bJzpuigUjyg152u5SzwVC6BmY?=
 =?us-ascii?Q?zQS65ZOnVh5EtpkDXpxfC7HdaE0N+j+aRDBamad4CkngBhZx0RSFXfXk4mWf?=
 =?us-ascii?Q?vpp6lZ63EPu7k2knf5hIQMsqH5QNjFMzfDip0M11XpzuImsBIc9G6qYmldKw?=
 =?us-ascii?Q?6Y9Dhl1D9BBOiiF7GQMf6WBOXv0rpkCJA6S8hcIhhZlsE/qrMvNdJWzE4uRD?=
 =?us-ascii?Q?X+8TxEWl4aVR1a8u27zrRRklfL/lwpwmAnMI1YekGGzkQqYDjJ3x3m19kV6N?=
 =?us-ascii?Q?uf8Z/6neNHsVZD6L1FYSRAwht3aiES1UgVSC5EKJ6kOo6d+QMdg2EJBmPmL6?=
 =?us-ascii?Q?STQft6Xhg+P8xqUKk6PjwrXTXHqDNos3eo6i7b2VmkwkXJ5mBH5WKdOMs0jT?=
 =?us-ascii?Q?lSfCzL1XzlmB2RVdPaJX8Jq7Awl7oVr8kTQ5+b8Tzhm8omu5vpaXdwrZ1ssc?=
 =?us-ascii?Q?L1sDHarw7Iv60rI4DtDF3Kw6mv+R7oP6eiKjWslwAj386WpwL4lpnBy8rlz+?=
 =?us-ascii?Q?u0+u+nqy+7iYIxN3AL1UMkTzUZxF8b6IG4FA28H8OXzGSUdZ8469H7VhBrO3?=
 =?us-ascii?Q?/wM7ZRjeE4rCa3Ufb1gNCz/YVZvkn6mhBNJnKPAV+u9LzK7PdouGHPWxvmFc?=
 =?us-ascii?Q?Yx7dYmLzZ/En3Chv9jpIo+E1892Jer+zql5DYX7HbIf/As31NCH+jqQmcacU?=
 =?us-ascii?Q?lYyyofXWNpsEZafRXJJclZxnzFtzZsnM/KQHVHXZ6KK4b3ADC2kLEciP+N1+?=
 =?us-ascii?Q?MbdyrMN4Z8FG6NEbWxlxZ8CYhZI5VfIedrRgTQ7bHmVguIGaSK6Smlp841BU?=
 =?us-ascii?Q?RtAR86ewrXSJ3MN/KdA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5237.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dad0afe-bc32-48c8-d35c-08da86309d40
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2022 00:27:38.0701 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p6HSiYSD4CwL6v9p78oim74ZuPl2LYwfvn/yPFPIg4pOfvXuOtaTZe+XaJiYOUzU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5644
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Yifan" <Yifan1.Zhang@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>, "Limonciello,
 Mario" <Mario.Limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Because GC_IP_VERSION 10.3.6&10.3.7 all use 1036 ISA version, one nit-pick =
as below. It looks better.
		case IP_VERSION(10, 3, 6):
		case IP_VERSION(10, 3, 7):
			gfx_target_version =3D 100306;
			if (!vf)
				f2g =3D &gfx_v10_3_kfd2kgd;
			break;


> -----Original Message-----
> From: Liu, Aaron
> Sent: Thursday, August 25, 2022 8:15 AM
> To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray
> <Ray.Huang@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>;
> Limonciello, Mario <Mario.Limonciello@amd.com>
> Subject: RE: [PATCH] drm/amdkfd: Fix isa version for the GC 10.3.7
>=20
> [Public]
>=20
> Reviewed-by: Aaron Liu <aaron.liu@amd.com>
>=20
> > -----Original Message-----
> > From: Liang, Prike <Prike.Liang@amd.com>
> > Sent: Wednesday, August 24, 2022 8:40 PM
> > To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray
> > <Ray.Huang@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>; Liu,
> Aaron
> > <Aaron.Liu@amd.com>; Limonciello, Mario <Mario.Limonciello@amd.com>
> > Subject: RE: [PATCH] drm/amdkfd: Fix isa version for the GC 10.3.7
> >
> > [Public]
> >
> > Add more for the review and awareness.
> >
> > Regards,
> > --Prike
> >
> > -----Original Message-----
> > From: Prike Liang <Prike.Liang@amd.com>
> > Sent: Wednesday, August 24, 2022 2:41 PM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray
> > <Ray.Huang@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>; Liang,
> Prike
> > <Prike.Liang@amd.com>
> > Subject: [PATCH] drm/amdkfd: Fix isa version for the GC 10.3.7
> >
> > Correct the isa version for handling KFD test.
> >
> > Fixes: 7c4f4f197e0c ("drm/amdkfd: Add GC 10.3.6 and 10.3.7 KFD
> > definitions")
> > Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdkfd/kfd_device.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> > b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> > index fdad1415f8bd..5ebbeac61379 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> > @@ -388,7 +388,7 @@ struct kfd_dev *kgd2kfd_probe(struct
> amdgpu_device
> > *adev, bool vf)
> >                                 f2g =3D &gfx_v10_3_kfd2kgd;
> >                         break;
> >                 case IP_VERSION(10, 3, 7):
> > -                       gfx_target_version =3D 100307;
> > +                       gfx_target_version =3D 100306;
> >                         if (!vf)
> >                                 f2g =3D &gfx_v10_3_kfd2kgd;
> >                         break;
> > --
> > 2.25.1
> >
