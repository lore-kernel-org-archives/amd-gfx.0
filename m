Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D768C4167B
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Nov 2023 10:56:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B7B410E23C;
	Thu, 30 Nov 2023 10:56:11 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2061.outbound.protection.outlook.com [40.107.102.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CF7610E23C
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Nov 2023 10:56:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iuI2SqyZrghnn8bcshSmUL2mHqgirKBqRWv6d/uyQZk0KzzuUHWHHNHRLSzi0iglcOsSAz0rY3TqBci1iYFNhZlqMtl46GNx3DWlpBT37aAtOpeTVxymwEvEI93oMYwjR2+zGSXEoHuVEg8hRqMGOH8gTm7iOxfNkE4uss8lZ2Jmm/gTFGBfdQuYtnZAjelB0SXIDYNNwX0ASAKdCqDh0U4uVF1lzyyqA58l2+YU9NJ+zwns1Z0cRrsgdjQeobdQ0sEGJljYoEIuXA8AmeFbHousc9ua/+pVzYoaritodEtmoRJC6tyTtsT+6X5fvjq1SAdQ67Zed/aTJR9zQWwZkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ojU4DGnpgLoSgXQAvvkeQwK004k496czktjsO3iwsSk=;
 b=byrDZkn3bmhZRO0W6/KB83Fdxt92A7eis8U8HukPdYv34TegTsoqF52cYUFkOxLlTJ+2FKuY9czeOCpYHPH6RK1cYdwbHwOdDi1ve7oLbHuyz9DcIWHZacEcrIDnFSuN1KGZ9T+arnfdJNUZd0LO0KYjB63I7RNYKdZtB9+DuEOt2Q+ppK/y54Bp7kJZ/kHnk6KKfAeM3retrKfNwfdJ5Dki1cbPz4TC7Z58oxBPClJxVb2GADFSbqxt0BhdXjdHTj5Cw83ZNRjeJXntBKs+gAfJr52rmuKYVNSWd1FSmyqhVv6CSHhwFxafNvxNE107VtqogPqBIzqWtf5+a/D+6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ojU4DGnpgLoSgXQAvvkeQwK004k496czktjsO3iwsSk=;
 b=P4861CyLYWUBO+uAh9H4DqR+JSLFhyG1LyE+5TBnpI7chv7oKmiU8W2iaz1Ul9qfWsdqFxsfIJ5xhgE6INaru8O4tiw+pra953NQz37yghzYCW7eyl7rbJ1FVZcll3Q6EfxjQh7T45FaGEEBx0qTgFE8lqJVbMBCeioYcaxBrVY=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SJ2PR12MB7964.namprd12.prod.outlook.com (2603:10b6:a03:4cf::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Thu, 30 Nov
 2023 10:56:05 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::f0fa:4908:b418:96d2]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::f0fa:4908:b418:96d2%7]) with mapi id 15.20.7046.024; Thu, 30 Nov 2023
 10:56:05 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: enable mca debug mode on APU by default
Thread-Topic: [PATCH] drm/amdgpu: enable mca debug mode on APU by default
Thread-Index: AQHaI3p/UTgGr/TQ1Eu8oQ90S253rLCSsI3Q
Date: Thu, 30 Nov 2023 10:56:05 +0000
Message-ID: <BN9PR12MB525717A274B4DBDD6C130FF1FC82A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20231130104623.2005351-1-kevinyang.wang@amd.com>
In-Reply-To: <20231130104623.2005351-1-kevinyang.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=5cbd1e38-10f4-415f-908a-dc9d3eef3267;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-11-30T10:55:39Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SJ2PR12MB7964:EE_
x-ms-office365-filtering-correlation-id: 06a5da29-04fd-470a-4708-08dbf192f365
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kecNY7FTR7JJzDGRgwgl60c7pwWTPB7xE4W3SBZP0/XFKk1TZyqVqzi3I5fL+4j2kBAH1/oM9kriaoOl944UKFLnV2j4rzpdu855r5mzsOZBEhs86UrFCbluEBUIDX98KNjLKw1hu8dfug2xFx0ZzlawgiUYkU89DXRpkK1rHLW3SypeXTqMDd10NKFeeKLfjyW9OdQ33TfsBl0q+pyTBFYpndVQCn0xLmM3qrG9hBHPnkdvxFDQ/XsCkIUjKDmTHuhRZEOYclAjo96WVrct0Qkih8GXoCUJnQzBAa0oZ6xaxvmkRbw0KQvQLkTH+1LweaLsR+JuX4383+J6bUvoq7P/n6AzWXYZI5TKaTFpyt2OwbUeJnfp3rzy+u3FQRIt5mTMzycCIr5798C9oWavWjgeHUm/e4rbQj1VZSVuipxTjw3SbnNnMYS46X+uLl/kw45pO+xm9e98g6yEZwkgNc1tN4XFdGYLFeXVKVNnC5ajsn0D5RyxTay43MuFaK1ctQwFkZnm3TsJ3uFpwXHiTmrUS+y/SNEkVSS2qwcWY/DPnsdPJrnE8R18VKcW5ptp89o0k3sH+3tQzU9Q45vdnazJxqxVeMar68eLtW2VXGxmAsLeeXR9VIkvdThTWpqp4ggn1j8SB/a3FqzfO9BDq8GKpa0trsJ7Yq7i8YaP2WM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(366004)(396003)(376002)(346002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(202311291699003)(55016003)(26005)(122000001)(33656002)(86362001)(38070700009)(38100700002)(83380400001)(52536014)(5660300002)(9686003)(6506007)(53546011)(7696005)(71200400001)(8936002)(8676002)(76116006)(66946007)(66556008)(66476007)(110136005)(316002)(64756008)(66446008)(41300700001)(2906002)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KCOjRA8ABgAPnADTKZswbxPHRjvGI2qI/5Zowdqjt440DNAIPjqqZmA0Tnqe?=
 =?us-ascii?Q?3z7Dpr7coBJsVF7/0+PaOgAoDZcDqRbDfEkh8cY2HWJrHEn2Wtq3z9R7Iz7m?=
 =?us-ascii?Q?IJXFZtwcjm+o48BDhs+tDndV7vhtJtzjApl6oF+7RyGgfRej3VY5lXqtNo2l?=
 =?us-ascii?Q?98glNIMkzK/EAzae/2lITPU1ws8ffZq/eBtOxcTkZu6YOTo3kZgbBXx1jfTY?=
 =?us-ascii?Q?0Io1y5pjHHISfq1y0nKNgEv6/JPFImyV9KOjE/zc0JUQC7wdr9a8cZq7wpIo?=
 =?us-ascii?Q?swNb07aUgMvpsdBcttgRKRbsec3p5qBhhWhZ/rtUArssYyiQ+1X8xzvKEs48?=
 =?us-ascii?Q?eCIIdy/2//fHWBHEB+pHkw++FWisYyxjYNzX5YCjPHX0CUCIX028ZtY1EbgE?=
 =?us-ascii?Q?FVquv1MtBFpYCicbqUk9glNZwkfuZRMAXNQ4XKGCWU12x7DOpDDnSRyhzawP?=
 =?us-ascii?Q?GYyburscJ/pl7XEZkVFzBQ2cuhCbzi9cM27HE46A6Qf72jlI4AQ2jxW2551y?=
 =?us-ascii?Q?Lm1enNHJJQ+NhLmfGFdwSJPPgQfCvxB3YCB93uVtANutrRKm+CSfb+vI/25M?=
 =?us-ascii?Q?eh8qDdcEayHur7HNefnMnB+fDPFwrE7dURVecdbSpRaa6FGvO5N6QFgA1UIF?=
 =?us-ascii?Q?eCNOi6jmgx5F6/ojXfcdEMUn776gn/qu4WxUysbmpOjTDGrK38eXWAZ6K7rI?=
 =?us-ascii?Q?C9fegjTwu/DDQAN8b55bWwvvVvuls614WERQJT57P9VfAIEB8XNYR4vjsXJy?=
 =?us-ascii?Q?cJZ2CSy6bYjaiGbLH/beCnTZ12g3WrJBUG0eFYU7Pjo5qhYL6VFHtX5NhIUr?=
 =?us-ascii?Q?ua+nJPGUNmG3CxNHWbUQtT9FEysXLJc5l1cXoYOGi6Vvc4os5wwIRMb+/bol?=
 =?us-ascii?Q?MpiWd6q93PnmrmQNsWwIIxiQQlw7d7zCMrRcOSEZ/QalKNvSYBoGQK0cxaAP?=
 =?us-ascii?Q?W28VvDgdKw56EdKwAhPCp5JWcY8/t4RFUZcgNSw+557SzehHkV1c1fY8E3qq?=
 =?us-ascii?Q?Aa7QH1vv6dHYb+/SehUIEHxEgnAo6z/EXwqzLHF0KicgmTjYo71AZeZMkrZH?=
 =?us-ascii?Q?+HBKo95YClPqH9c19BwrV/hWbHXcxomoqAWwNgfwikBVmo9JO++klRfAecYM?=
 =?us-ascii?Q?EDE/UCoRCuQGaQBNnb96z+Qo+pmiV2AsihEYJTv3AXDtNyAgOovO8ltKuji0?=
 =?us-ascii?Q?c+OF7/qv71mznqmDukpDUMTDhHrcYPCzs+Gzjrg17vhSfr9kcIa63tsGc1bo?=
 =?us-ascii?Q?+67/p5+8GnSi8v+vY30XLd37by+K6VwE7U57F02MczRSRz8iH8kr6p4LUIBM?=
 =?us-ascii?Q?XgSXkKJQe1M22cL6RM1zjXQEWEPvu6M48hMXJ/TSRIE2gBOuyB7txHUGK0Bx?=
 =?us-ascii?Q?vo999hNx9A77aqHnA2UW0H5MHEkb4UPBAcAC7WCdJ6f5Y2ed6ErBSz3PChpk?=
 =?us-ascii?Q?1Dx5t5naCUqg+T5j2UoFmkEgSV4Z+ORKAGi5m86g7T3dDGu4PRwH6CVBYYgL?=
 =?us-ascii?Q?hUVoZZUM9Tl2MZLGs0UQwKFhJoQyNMj6p9QDsBjVAuNx1oVDZFz6QeLezROa?=
 =?us-ascii?Q?Oq0oDeYlrb50furUWD7HCHjtzGwEQBbdH2FGvG6Z?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06a5da29-04fd-470a-4708-08dbf192f365
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2023 10:56:05.3460 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SrQpvj0nNTitejJBkDwAx4cvnjcjqje6KXXehp1UH1irJmC5EE/Eh7DHl7M4Q8bPo3RZbsnfwl9XP9rv/hZ4wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7964
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

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Thursday, November 30, 2023 18:46
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Wang, Yang(Kevin) <KevinYang.Wa=
ng@amd.com>
Subject: [PATCH] drm/amdgpu: enable mca debug mode on APU by default

enable MCA debug mode on APU device by default.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index f6b47ebce9d6..72634d675e27 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3132,7 +3132,8 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev)
        if (amdgpu_sriov_vf(adev))
                return 0;

-       amdgpu_ras_set_mca_debug_mode(adev, false);
+       /* enable MCA debug on APU device */
+       amdgpu_ras_set_mca_debug_mode(adev, !!(adev->flags & AMD_IS_APU));

        list_for_each_entry_safe(node, tmp, &adev->ras_list, node) {
                if (!node->ras_obj) {
--
2.34.1

