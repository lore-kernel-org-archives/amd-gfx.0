Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C6EAC433FE
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Dec 2021 06:23:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 799C510E1B2;
	Mon, 20 Dec 2021 06:23:40 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2086.outbound.protection.outlook.com [40.107.236.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9595E10E1B2
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Dec 2021 06:23:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E9OGGoUDXiPLShho4SFE1Sok//0aNBuZv5GbFdXwzOp3n703LaTZAv89EtxS6rnVRDwCkkzjZszZ655gKOjiIUX+AMDgmTGUqRBkRQsQ/CDP/TLJNe27ioz7Z+ykpyHr5RF2qVKzRVpbtk/Q8Rwry7ceHd6WdKcvSD4bF6NuNJtJiabPSlvIWCxA6f6qONEstTxkFuTVS+ajBTe50xmieyr+qyMb66wSpkzGZ6kohKoPVd9B+MXRDKU8LWpqCcLq2NWzpCip6KY7s3h7fxrRfSAYhFsgYE5pBsBIyxJ7UOWKjczZCeiiubATA/VWvHB1qApjuSrFuATCqzOtkqIqGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/t363dHc1Z7FDFNAv+4kVSZ9uD+OXx0Sk/gBgh+NCTY=;
 b=QvlqzCPJRw12D5x09WdtPXE6bvJH2oL8BXcnZdwEohdxBtnmB7QDmyi0I7aToQFsByw/sVOiPjyKkxd946wq+Ph8lfTvW9QCT57KPwShc9I8mc6b90sFww9/8KAVMZQ01PMlA0WDWjiyP2BjQl/Rv223AADs/aOSnbh2WMsXckpL6Bc0FtPMfRQc8HESKXBpjENr6eRpVYulYQBo5BU24IxBR7oOJnRjgWrS+J1XPf03m10at+KRavVLfK6BhuvxFdZaD5Qn5YBwlvgLA6DgT3N+AVEQGk3cGABIYR7h6Nt0+J2K/v/tbJAk/kQBwGWZWVUaxl053+NO1v0wIslU9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/t363dHc1Z7FDFNAv+4kVSZ9uD+OXx0Sk/gBgh+NCTY=;
 b=zxKnHSuOw0J8T9ZuxGZmcpVCr8ZVTbjq7xhRElvrR7oNfIcO0GVroEs9/qIpUYlaob10/I7E4Nno91wv4Y1lrm+DNH2Uj9qOFFwbHnsJhgdPL566LafCEFSNUouSIuRn3y4sHZu1pZNx8w9QruZvHEeGVIef7twEyzQucnUmunw=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM6PR12MB3689.namprd12.prod.outlook.com (2603:10b6:5:1c7::32) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4801.17; Mon, 20 Dec 2021 06:23:37 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3562:eba5:418b:b43e]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3562:eba5:418b:b43e%5]) with mapi id 15.20.4801.020; Mon, 20 Dec 2021
 06:23:37 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Sider, Graham" <Graham.Sider@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: RE: [PATCH] drm/amdkfd: correct sdma queue number in kfd device init
 (v2)
Thread-Topic: [PATCH] drm/amdkfd: correct sdma queue number in kfd device init
 (v2)
Thread-Index: AQHX9U737KfzJJVPH0COspFqBXpgvqw63m6AgAAKo5A=
Date: Mon, 20 Dec 2021 06:23:37 +0000
Message-ID: <DM5PR12MB2469E5266574059C1DE64470F17B9@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20211220030849.32458-1-guchun.chen@amd.com>
 <DM6PR12MB3163F586AB5EED14E56AA455857B9@DM6PR12MB3163.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB3163F586AB5EED14E56AA455857B9@DM6PR12MB3163.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-12-20T06:23:30Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=dfd00757-6994-4e38-873e-4eb2f6be2a92;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2021-12-20T06:23:33Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 61a04c17-e772-4ca7-bc82-f8388d804a15
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c6c2a4b0-d93e-45ae-1ab1-08d9c38141dd
x-ms-traffictypediagnostic: DM6PR12MB3689:EE_
x-microsoft-antispam-prvs: <DM6PR12MB36893A67CB20966D3BD967DDF17B9@DM6PR12MB3689.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KuGqHky0AWrIoXy4eeMITfM7nzpta7lIG1uHZi2n8XQMcfXKZiqIlNZ0TdDr6GH+5byeGnTOR19UdVrHon8yKFHh8WM3P+SqasbZbqA7zyWivBpreRd01yeZFUMVt+zyIwyV46aI7mdyM4PFLPj00X7IJlQ6r/SQyBT+aD6Oc06kvwEpvSprVrb1kRILmgUmTId0iEuyDUiXHfxhkUvn9riN2u6JpshLjoXAcFy7c8/7U+5TRa7LsrXSSwnI7zMrNy8v0H0Sonn3s93ji9KdoX/DZbtBKe2NAP5q6ucV+rnOnPjr+FE3b7nAILwgiXVn2TcTQgQwtBtLru/PRMRzNFA2a8N7e6hdo0BVzU2ai46SUZgXRNynCb2rEEDgDOxcWDysZkyo11sEsbJi33KlaiUoUAfpz/GGQovE7pMCHLiRPkWn6ujpfAR0CtaQ4hsb1QYPtfitxxHwk/4MJHQ94CionX3tz2matX6HhIU8FrfKdOOaJu3BItQMPPGo2B3mgJRnog+OFRVsWfazeO4R5Jwgo5+a+RUZZz0uKh8TbOM1Rg7rZMmOQjwf7sx7GHQOaZFepWQ0U+959sbj04O5czdCaN4A9FSVLrubnQnMCt4M/bUwCIiR+hD1PPG+9WLkvlRZ2h30eqLYF2DL95o8Zd3r5suQBpwUzLYBWpb5Y+Qu7GImpZeGWyiwvIy54K3DcfLes6K4DIoBZxMgEFrGnA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66556008)(6636002)(64756008)(66446008)(66946007)(71200400001)(66476007)(7696005)(122000001)(52536014)(38100700002)(76116006)(38070700005)(5660300002)(9686003)(33656002)(83380400001)(8676002)(8936002)(316002)(86362001)(55016003)(2906002)(110136005)(26005)(186003)(53546011)(6506007)(508600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kB2A8xr5Ud8drA73LSlvbXLs1AcC0Ubf1epC2UhMNHH6BxTweCA/UFrXvnlp?=
 =?us-ascii?Q?5iTWLu3t7qnWFDUIHWxgJGr76hCDQ1ljVs9aTIkgMdOwItzkEtn1k2KByHzU?=
 =?us-ascii?Q?OBb8u02wQQUz1txDqjlV5d6bISpY1hzqWYxW2z9ZN1loRpqMPtcnUX5KClCI?=
 =?us-ascii?Q?iy4CVfquUC3BrqI4ezh2NJKCM5Flfcv14E4Zii+8Z50xGvtQLG5FUAqTAVVl?=
 =?us-ascii?Q?jcQHwinK/0sqvgicqsDWAOTN+woZ/1mrBvb1Degod3rHiekbrZFzWQQF+S9E?=
 =?us-ascii?Q?4JpnAyR5FibV55xW3a2+uR9LXTTJAj/sklyRgzkre/fQT9b5YS+P2bQiqdKr?=
 =?us-ascii?Q?w2vESv+krcvwYm+CWutN02sEyzGqOoWNBxSj2l8lWTIkdO8DYY3RUVUNyiSE?=
 =?us-ascii?Q?5SLPu72ABFsR2qWEKkrLDZfknbFUC8H+QfvjFHS0eKZUbJD5xW4M9pVsmvWu?=
 =?us-ascii?Q?0S1daW1ldEQSsPviZe/h0bFQhezTWxQ/ll8SV7BWuLImSj/qASuSKQ1IGHv9?=
 =?us-ascii?Q?QZC3pwm9faOcr2g5Omc3WMZtuCZVkb0JQeCNJVBQESsVyLRwcPGmMnYRzSou?=
 =?us-ascii?Q?Jo5tyzPHSXiUupI8Y/0tby5ZAWPlYsjIie18/kJ2rMUw5626MUX6mRbKLpt9?=
 =?us-ascii?Q?PKZ9xstcuA93v40MlooeAl0hiI8Go89rNTxgdYvm+rPFIlhsyN8Nwstul1rN?=
 =?us-ascii?Q?3XB3qrld6ovUVVetYMd1nx77aSHaEWJRwPvZuc9hd0K5Ye6mMQPiJHpwoaqB?=
 =?us-ascii?Q?8GO5qZull1nxrHrYiigKIUQ4PLHfgsp0SeBOA6u0AUbaEaFKdb5sxxW6FLDL?=
 =?us-ascii?Q?hd5nBaWX1DP7gAWHcB1WDFdT1CTtLV+4XUWtv98k1IX3PIs550LCKTbz6FgI?=
 =?us-ascii?Q?U0Him2FuCkObyYiUT0gY8owpjFVpXd41HmYzxec9CQPM/3Uwrak2L0QPL6mz?=
 =?us-ascii?Q?gRFAowUui79nAj1ArpkiYThE+9OJ0sf+X2bNTCcmdMa56mrazb7wmXyTtuIW?=
 =?us-ascii?Q?5jvMmOCSS81l0JuznM5/kIIpMW9D4wdyGqPx1tmmBW2xMW/i+8TYTcBWG7zt?=
 =?us-ascii?Q?iSCaBy8opp8geumFXKHUvIxT5LqZ68eMsCCwVZX6+HGwgyWJ+2XopeSaBA4I?=
 =?us-ascii?Q?8vf6Iz5oGL0bzSgfcB7/FTNqoAyXsNlL8sv0Sy8alkERhZzgRzlblJsc2vS2?=
 =?us-ascii?Q?n/dxUu6M8HddVbBsf6p11FOzqHaZ5XjlOpzkpvzn6pp0WabDoWrbpxFU24R8?=
 =?us-ascii?Q?z7JDxCMQoI8CDnry23lo1GYWM/D2/uJi47hgH/+Ygh2wuPq6p48RUCq/ZwlG?=
 =?us-ascii?Q?CbvYrKc6QJYGWUlChU8M4IsC45nN4/wJ/39EjDUpjStDdGzm7D70XbHqFpbG?=
 =?us-ascii?Q?zoaxLJIcaNwTXypgZ8Lyaw041tk5UTd7jfre/T+G/M1uUCzk31o+nwQ4Shtt?=
 =?us-ascii?Q?Jj4gT6PFCagBj79YzTIA37U5ThZWGJa8+P6NO5jG90i0OD8Jc6i7M7oZGXpg?=
 =?us-ascii?Q?JxxYq6UwV4hEKgggyoJ+jVzCzHN0cIjg3E/J0BIoxMq7q/yiDUrGo1X8xKZ8?=
 =?us-ascii?Q?GBlEz49E1H8mxjSrdIWKiDk5cXpuAHPk8J9MG0Dv3ki7450EIf8q/gjpPI+Q?=
 =?us-ascii?Q?icKVL0O66bdKai4z9RQnEg8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6c2a4b0-d93e-45ae-1ab1-08d9c38141dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2021 06:23:37.1124 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mXtN5F1CyD/JIBY0s7En9xtR58b84KDrf1osC43/1tfNWrF9venTVNk7cDuHamdfcqGcGfQ7TKvwFLjkYMVuiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3689
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

[Public]

> sdma queue number is not correct like on vega20, this patch promises=20
> the

I think you've also fixed Vega12 and Raven (they were being set to 8 before=
 rather than 2).  No need to mention this in your description, just double =
checking.

No, sdma queue number on vega12 and Raven is correct, it's 2. Anyway, I hav=
e dropped it in the commit message of V3.

Regards,
Guchun

-----Original Message-----
From: Kim, Jonathan <Jonathan.Kim@amd.com>=20
Sent: Monday, December 20, 2021 1:44 PM
To: Chen, Guchun <Guchun.Chen@amd.com>; amd-gfx@lists.freedesktop.org; Deuc=
her, Alexander <Alexander.Deucher@amd.com>; Sider, Graham <Graham.Sider@amd=
.com>; Kuehling, Felix <Felix.Kuehling@amd.com>
Subject: RE: [PATCH] drm/amdkfd: correct sdma queue number in kfd device in=
it (v2)

[AMD Official Use Only]

> -----Original Message-----
> From: Chen, Guchun <Guchun.Chen@amd.com>
> Sent: December 19, 2021 10:09 PM
> To: amd-gfx@lists.freedesktop.org; Deucher, Alexander=20
> <Alexander.Deucher@amd.com>; Sider, Graham <Graham.Sider@amd.com>;=20
> Kuehling, Felix <Felix.Kuehling@amd.com>; Kim, Jonathan=20
> <Jonathan.Kim@amd.com>
> Cc: Chen, Guchun <Guchun.Chen@amd.com>
> Subject: [PATCH] drm/amdkfd: correct sdma queue number in kfd device=20
> init (v2)
>
> sdma queue number is not correct like on vega20, this patch promises=20
> the

I think you've also fixed Vega12 and Raven (they were being set to 8 before=
 rather than 2).  No need to mention this in your description, just double =
checking.

> setting keeps the same after code refactor.
> Additionally, improve code to use switch case to list IP version to=20
> complete kfd device_info structure filling.
> This keeps consistency with the IP parse code in amdgpu_discovery.c.
>
> v2: use dev_warn for the default switch case;
>     set default sdma queue per engine(8) and IH handler to v9.=20
> (Jonathan)
>
> Fixes: a9e2c4dc6cc4("drm/amdkfd: add kfd_device_info_init function")
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>

Other than the missing checks for Raven when setting the interrupt class (s=
ee inline comments and reference kgd2kfd_probe in kfd_device.c) and one nit=
-pick inline, this looks good to me.

With those fixed, this patch is
Reviewed-by: Jonathan Kim <jonathan.kim@amd.com>

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c | 77
> ++++++++++++++++++++++---
>  1 file changed, 68 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index facc28f58c1f..36406a261203 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -59,11 +59,75 @@ static void kfd_gtt_sa_fini(struct kfd_dev *kfd);
>
>  static int kfd_resume(struct kfd_dev *kfd);
>
> +static void kfd_device_info_set_sdma_queue_num(struct kfd_dev *kfd) {
> +     uint32_t sdma_version =3D kfd->adev-
> >ip_versions[SDMA0_HWIP][0];
> +
> +     switch (sdma_version) {

Please pull in the indentation for all cases to line up with the switch blo=
ck.

> +             case IP_VERSION(4, 0, 0):/* VEGA10 */
> +             case IP_VERSION(4, 0, 1):/* VEGA12 */
> +             case IP_VERSION(4, 1, 0):/* RAVEN */
> +             case IP_VERSION(4, 1, 1):/* RAVEN */

As mentioned, you've also fixed Vega12 & Raven here I presume since afaik, =
they're based off Vega10?

> +             case IP_VERSION(4, 1, 2):/* RENIOR */
> +             case IP_VERSION(5, 2, 1):/* VANGOGH */
> +             case IP_VERSION(5, 2, 3):/* YELLOW_CARP */
> +                     kfd->device_info.num_sdma_queues_per_engine =3D
> 2;
> +                     break;
> +             case IP_VERSION(4, 2, 0):/* VEGA20 */
> +             case IP_VERSION(4, 2, 2):/* ARCTUTUS */
> +             case IP_VERSION(4, 4, 0):/* ALDEBARAN */
> +             case IP_VERSION(5, 0, 0):/* NAVI10 */
> +             case IP_VERSION(5, 0, 1):/* CYAN_SKILLFISH */
> +             case IP_VERSION(5, 0, 2):/* NAVI14 */
> +             case IP_VERSION(5, 0, 5):/* NAVI12 */
> +             case IP_VERSION(5, 2, 0):/* SIENNA_CICHLID */
> +             case IP_VERSION(5, 2, 2):/* NAVY_FLOUDER */
> +             case IP_VERSION(5, 2, 4):/* DIMGREY_CAVEFISH */
> +                     kfd->device_info.num_sdma_queues_per_engine =3D
> 8;
> +                     break;
> +             default:
> +                     dev_warn(kfd_device,
> +                             "Default sdma queue per engine(8) is set=20
> + due
> to "
> +                             "mismatch of sdma ip
> block(SDMA_HWIP:0x%x).\n",
> +                                sdma_version);
> +                     kfd->device_info.num_sdma_queues_per_engine =3D
> 8;
> +     }
> +}
> +
> +static void kfd_device_info_set_event_interrupt_class(struct kfd_dev
> +*kfd) {
> +     uint32_t gc_version =3D KFD_GC_VERSION(kfd);
> +
> +     switch (gc_version) {
> +     case IP_VERSION(9, 0, 1): /* VEGA10 */

Missing check for case IP_VERSION(9, 1, 0): /* RAVEN */

> +     case IP_VERSION(9, 2, 1): /* VEGA12 */

Missing check for case IP_VERSION(9, 2, 2): /* RAVEN */

Thanks,

Jon

> +     case IP_VERSION(9, 3, 0): /* RENOIR */
> +     case IP_VERSION(9, 4, 0): /* VEGA20 */
> +     case IP_VERSION(9, 4, 1): /* ARCTURUS */
> +     case IP_VERSION(9, 4, 2): /* ALDEBARAN */
> +     case IP_VERSION(10, 3, 1): /* VANGOGH */
> +     case IP_VERSION(10, 3, 3): /* YELLOW_CARP */
> +     case IP_VERSION(10, 1, 3): /* CYAN_SKILLFISH */
> +     case IP_VERSION(10, 1, 10): /* NAVI10 */
> +     case IP_VERSION(10, 1, 2): /* NAVI12 */
> +     case IP_VERSION(10, 1, 1): /* NAVI14 */
> +     case IP_VERSION(10, 3, 0): /* SIENNA_CICHLID */
> +     case IP_VERSION(10, 3, 2): /* NAVY_FLOUNDER */
> +     case IP_VERSION(10, 3, 4): /* DIMGREY_CAVEFISH */
> +     case IP_VERSION(10, 3, 5): /* BEIGE_GOBY */
> +             kfd->device_info.event_interrupt_class =3D
> &event_interrupt_class_v9;
> +             break;
> +     default:
> +             dev_warn(kfd_device, "v9 event interrupt handler is set=20
> + due
> to "
> +                     "mismatch of gc ip block(GC_HWIP:0x%x).\n",
> gc_version);
> +             kfd->device_info.event_interrupt_class =3D
> &event_interrupt_class_v9;
> +     }
> +}
> +
>  static void kfd_device_info_init(struct kfd_dev *kfd,
>                                bool vf, uint32_t gfx_target_version)  {
>       uint32_t gc_version =3D KFD_GC_VERSION(kfd);
> -     uint32_t sdma_version =3D kfd->adev-
> >ip_versions[SDMA0_HWIP][0];
>       uint32_t asic_type =3D kfd->adev->asic_type;
>
>       kfd->device_info.max_pasid_bits =3D 16; @@ -75,16 +139,11 @@=20
> static void kfd_device_info_init(struct kfd_dev *kfd,
>       if (KFD_IS_SOC15(kfd)) {
>               kfd->device_info.doorbell_size =3D 8;
>               kfd->device_info.ih_ring_entry_size =3D 8 * sizeof(uint32_t=
);
> -             kfd->device_info.event_interrupt_class =3D
> &event_interrupt_class_v9;
>               kfd->device_info.supports_cwsr =3D true;
>
> -             if ((sdma_version >=3D IP_VERSION(4, 0, 0)  &&
> -                  sdma_version <=3D IP_VERSION(4, 2, 0)) ||
> -                  sdma_version =3D=3D IP_VERSION(5, 2, 1)  ||
> -                  sdma_version =3D=3D IP_VERSION(5, 2, 3))
> -                     kfd->device_info.num_sdma_queues_per_engine =3D
> 2;
> -             else
> -                     kfd->device_info.num_sdma_queues_per_engine =3D
> 8;
> +             kfd_device_info_set_sdma_queue_num(kfd);
> +
> +             kfd_device_info_set_event_interrupt_class(kfd);
>
>               /* Raven */
>               if (gc_version =3D=3D IP_VERSION(9, 1, 0) ||
> --
> 2.17.1

