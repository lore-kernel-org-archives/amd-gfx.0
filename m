Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98254CA0EEB
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Aug 2025 03:32:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11A1310E85E;
	Thu, 21 Aug 2025 03:32:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0zDJ3bsW";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EB2E10E85E
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Aug 2025 03:32:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HS1LFTztO3GMaY6GviBaVLWNacdxaIyKyIE3nZMq3YVenkq6zi8SSSKecepjlQ/GRwskQn8ruCye4I50yllM1Lurg/NjkuBHozG2sdNGpQiD1uaji2wGXUEnrVnM1x+CScfeMI+N1XarmaFAfj/gCjukwBH6lbdwkvpmlK8HeC3+jmtbhiSlV/tvKUU+9LAzOLKePwFHMs/GhKQe9ERCdLbtq61X83Zfp+C7iatwizi1xX8vGJuH/fd9jLMLWzdCpTI1rT6QdOPDwBPztHEpPH00OG9VJCthn7Cn1yp8Ga9gqHQGpx0DFn0uUAfe0RvJeIjre+/h294O+0Xr82Agew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tBb5UCEbLaRD14vfNNllzN4S29jGj4VNWqOZgov8afE=;
 b=V6XcVu28IOWGU4hgQgIVeior16vmRUw/ymDCiFWdy5iWsjIH8JcrwklBFPZTmpv+3o9TCsn6KiDCcfcc+Ch3htH6km3eCFbFWVxho9TPl3Gb1WS4GJvlVnO35QmD/ulfYK+CK+4pId2fEGr81pkg6glWRfYBmzLRVNbaCXeLq41FMSQq/rFDhfs5RuEAz+35JKqpI2kUFs1wfrhigGj1/ZDgC9+PXu8j1OVIPqed0gidg7UDDaAPz0hRlBrBa2XUdRsU4oRQKhebxGQuaWbn2UyEogi6/QTMEwdPdscfWCl4uKMsobUpCRBZNIOL2fwDOzYt4SbogpgPEN16qprLhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tBb5UCEbLaRD14vfNNllzN4S29jGj4VNWqOZgov8afE=;
 b=0zDJ3bsWYgI6E50XynvM38uZL6685WrkUKmTAR2yPxDeXuHYk9CcY5XvMBYa6H3wEiL1ZJTh+msspXQng8jyfZQ44tlP6jHiKCLJ5MSRxtsivv/ROPcLgx1cSA8soi5VRnRXJjpigABVJZGCcy/KcexskwnliH2UbbX0KfW6XK4=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BY5PR12MB4260.namprd12.prod.outlook.com (2603:10b6:a03:206::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 03:32:31 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%7]) with mapi id 15.20.9031.023; Thu, 21 Aug 2025
 03:32:31 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Sun, Ce(Overlord)" <Ce.Sun@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Add support for dpc to a series of products
Thread-Topic: [PATCH] drm/amdgpu: Add support for dpc to a series of products
Thread-Index: AQHcEkqJgpY+qAV/rkqLCWy3AwF2WLRsc8bQ
Date: Thu, 21 Aug 2025 03:32:31 +0000
Message-ID: <BN9PR12MB5257BD362D75D2C1EC6A554FFC32A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250821032013.336835-1-cesun102@amd.com>
In-Reply-To: <20250821032013.336835-1-cesun102@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-21T03:32:10.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|BY5PR12MB4260:EE_
x-ms-office365-filtering-correlation-id: 4b20e878-9774-46c1-2098-08dde0635c8a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?fWCB7dEb+/NcGuXgOD3wZHi015jJ4u65PK8mdBBU6sUcL4BGJJ2/tLAJqiUh?=
 =?us-ascii?Q?K2koHmbJZUnBnBXn/Dx5PYH2jtiXEbDeIhmSo6CDcrc/7B4TX21WqiHlOYlp?=
 =?us-ascii?Q?EHqAp/wRHvucEsIKIh5vkLEZTqtpgYKXf9gtlJVRB8gPCctRGARVMpFwbBsJ?=
 =?us-ascii?Q?03y8tz7OA/bGbgJ2dCkb7dTKzUcy4X9jg27pTyfJOGwEnfNIE454nySD/oTD?=
 =?us-ascii?Q?gnulUG/nS0CKmINY/2XjvyCD9hzkJg1eA2HBz4W8YYoU2mJhvurq9exFSKju?=
 =?us-ascii?Q?rNEplkvHj8+7XHC8BzZmF/GaAsGlDQa0lUu6ji3WRpzLyatkN94DERxOCYXB?=
 =?us-ascii?Q?uW5nkx284wd678AVudKJw16hQO8991unk5tcIq9fjj2EKzRKhPPEKnoxNlH7?=
 =?us-ascii?Q?OL3MXm5aM8KXGIpxX3J5FqePZ5P5+sbxILpGXUnP7SPsnxSpedtqlCIz4dLm?=
 =?us-ascii?Q?onQ2ykG53te/mYO+/QkMDZS2capPffN6MJTC4k3u2+iEIYShpAAuSSj7ug87?=
 =?us-ascii?Q?VLdFVncC6MfKVVhm0arClYk5CaBuUKQxLUodO7vla0YlTLUL123ZUgqKu8ZI?=
 =?us-ascii?Q?ZkpIN1VNT0BgStnz1nTnwvRbWvO94NMSae7D+679ec7svuENWb2Zhwua+mJy?=
 =?us-ascii?Q?jgaFDUQqzLiB2fxxYrINx0mb7HuCtja0yVVzAjqq4hnjfxxP479F6gsJuy9r?=
 =?us-ascii?Q?FU50BPBZd/i57V3RuoH76i5edb/pjhVVNnxFGqTzcq29lbH9knclKl2scnJX?=
 =?us-ascii?Q?jLrMIP77yCb26J3A5oxMF/G9dnih+ZSJvzeQYl6D2E9UJy6889WONWISeJBs?=
 =?us-ascii?Q?Gx0rW8qk/1X9gt1AYwKM2WeGz++Ed5QVPLxxNuhDiPAK8InxR2cqk5RNj4o2?=
 =?us-ascii?Q?Zcp62UBl26vGAazqM6aiACpOplZ0Si/jUfJZmDPSVYaai9s+qJI1sNYDYG/i?=
 =?us-ascii?Q?axVH5NHYq692FYFF4mC6Ed4XsE/YUHPpCLXvSdmObsKDaENQMbK77TsEd6Ue?=
 =?us-ascii?Q?SW2jI9ASPDANZRzoPJwb4Isi7PY+droBwYbbziD6RTa5EeHXHaRXcXk1Urjk?=
 =?us-ascii?Q?np236+QZo0AUU9F0kltozBcLb0U39g08eOa53lJLWdTnaxmtYsCn9HCxOICa?=
 =?us-ascii?Q?Q6bEgmGjUUpQtNtS3l/pin9aO+E2zrVLUsQWu0Helc1xdPhdIolG/SeRsAQB?=
 =?us-ascii?Q?kb1J7eiuHHdWVPHGT2SNvxORmMvBQeTiT6fjRHgV4RLfuYJQbtHK7gGvDK72?=
 =?us-ascii?Q?2gTiX9+Y3XX2/bF+tBwla9EzTbyd8UP5vNqZpmXtZOJP0l7YiFT5/i35XN6J?=
 =?us-ascii?Q?kQnzP5nsFzOUItthRNjE3o6sa6yoAWWDGIKX+kcC4podiW0FQdMKDAKJdixT?=
 =?us-ascii?Q?EF+g0N9HycKpu+kBDmntiteVOVKORVPPY6OiZsv8GIW9nHKThlvHZ+9odWEA?=
 =?us-ascii?Q?6ArRR04sU+I73yfth0oi5Xtku+lrlvLEF3e2r5pGQ3fb4HMpeaZX8w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Thga02GFfQKFjx36Heql6krT2Df5qjD+8BMaIf+t8pWoxneAgVBcNnwRZ9KE?=
 =?us-ascii?Q?pcO5dl9K3myj93MfK4PxPC8Bq6r78ZWHL3ib72NBfya35vvJ2EliAGd+jRk4?=
 =?us-ascii?Q?2+Iey1LJanYEa6EseS7gGe5hRY3o9bpCfrY8kGlxDSLb7F9oitSp62YCJl08?=
 =?us-ascii?Q?gsD36s8ELEqZ9HjxKXQyhz8Y+3te3/nVUMxjAteDMEO3fCbfVhxTQ83fUfHo?=
 =?us-ascii?Q?eeG5ytZg6eDSWEZw0COgpduyI9vFWB1QNy7Is+5PFzhfp1/0br0OFKFh5cPa?=
 =?us-ascii?Q?tBcbz650JjoXSOqzGUnuZI1+O3cNOgiVbcQiKrwO6hN34hOdJbmD83z8lLJm?=
 =?us-ascii?Q?LvhRw1wffO9ugS+4hzlDJxFi13pRC3jsrjvZ6k3ahFZr6kIed1mZulKPQkcg?=
 =?us-ascii?Q?sC64M3RU9QV2XDrAGlSFa3nJF0wdPdc5UX6yneCcBAJbvirwHBWHtjZcrUZP?=
 =?us-ascii?Q?9fTzStG7H/k31h85bz7iHZXhBsLSs5zZN4e7wsf9fAnQwr9RASV8VxkbzBWa?=
 =?us-ascii?Q?c7O693VYOcKyAlVZWMnprvsD2F2z4V09ULEFeT1k+gCIoufIfkz+oyFoDW65?=
 =?us-ascii?Q?KA8lJCvh2hNtA8rDA50Q1Ig3gCYI2tqs0UiHxonivPFI6XF30G0H9woaxWoo?=
 =?us-ascii?Q?JNPBkGUl7k2OqZRmaKsvf4GiLk9HoWqtIJXnpXS82HZ0sxBr53yFITR0CEns?=
 =?us-ascii?Q?qtZ8G6Fs5uexz/sDnw8XCQS0UWT3VLQKwH0j7r//WEMWtklECFKdtVTvxuhf?=
 =?us-ascii?Q?hdTeFVivlZw/Tqi9BiSgvYmVWgSL6wq3+zQQg5SS/6bP238hdHejHYqjMp6q?=
 =?us-ascii?Q?PeqaRERRPFqXZUCREf0NSidrCybiTfqNv3zFPlnur03d9b4qANCIvhMBBbdq?=
 =?us-ascii?Q?+PZMYHVkqolvmufsU5uzFAN2+l4khgws3X4FI6ryjsfQ3wh1jaDCeo+QGm9i?=
 =?us-ascii?Q?WmBafaK0UonXJ04eZwRLlhFgHsHA+5AeTOkgyH08EuW/vs/GQYpd7YjSE+QM?=
 =?us-ascii?Q?AwZrnN2b+hzB22Dc4TRBBl8HoMjZGwBC2+OGcvRkWsdjTwSpIdDY5hzteKK0?=
 =?us-ascii?Q?APewaFI5hjrfOaOF7USI0vYUdL6EUKiPOUSqn+wdve8QuDrlk9BbPjDv5tNq?=
 =?us-ascii?Q?XNAw8d4L+La1vwIaFg5ZUkqhrDPK6cNo7vaEKdJFLU27ui5UGVnxnqY5bJPM?=
 =?us-ascii?Q?/T/jW1wzOH5LaFKuEkiprfjBFt3QD4tf2mp4tMH8o7oMI6knuI8RfLT6cbK0?=
 =?us-ascii?Q?jrHgoJqJ1R+rW1+yZjXev/D/UgtIZ1uR2/cvy/QG5G5LXqf5JDldK5yUid+U?=
 =?us-ascii?Q?dO6YL5q6HcCbiqeoceaKVmncui4YqSoGrV8UGMQoJedNo4DEYWFQlftHgVFz?=
 =?us-ascii?Q?MokbYriLjVKdva9gT/mfDuWVcM5Ur5rVjtWtYmEFaL/bUhs4l1YBlTVkMbnm?=
 =?us-ascii?Q?gnXLV9HbJlVADR1lXhJQ17AAW4BHA/GRaBrsdBl5MssC+eNwfLaGnh1h66pD?=
 =?us-ascii?Q?1kunk1Z2RNBqB6BkZabDzTZ2U3wxbECRXjUzAf+VKyyucgVA6+ClJczjVERo?=
 =?us-ascii?Q?GgrH/K0H3VPUtkk/FxE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b20e878-9774-46c1-2098-08dde0635c8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2025 03:32:31.5290 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OS4PXBXKjdLie52AQfQY3BOBqfF2nDkA5ju6azxqgDuPWqoYrizTNn5p0qbKebyTW0BA8SPFwQpeMyTN93oJhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4260
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

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Sun, Ce(Overlord) <Ce.Sun@amd.com>
Sent: Thursday, August 21, 2025 11:20
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Sun, Ce(Overlord) <Ce.Sun@amd.c=
om>
Subject: [PATCH] drm/amdgpu: Add support for dpc to a series of products

Add support for dpc to a series of products

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 627a8188d868..a4be035fff30 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -3135,7 +3135,7 @@ static inline bool smu_v13_0_6_is_link_reset_supporte=
d(struct smu_context *smu)
        struct amdgpu_device *adev =3D smu->adev;
        int var =3D (adev->pdev->device & 0xF);

-       if (var =3D=3D 0x1)
+       if (var =3D=3D 0x1 || var =3D=3D 0x0)
                return true;

        return false;
--
2.34.1

