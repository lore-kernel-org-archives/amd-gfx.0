Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75C6EC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jan 2022 20:21:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0093810E14D;
	Tue, 11 Jan 2022 20:21:19 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2076.outbound.protection.outlook.com [40.107.236.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36A6610E14D
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jan 2022 20:21:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C/RQziCpGqpHMeJKAXT7PRbuL7tbAX2hsy1Nn4Rcynl/cXo/iRpqW9cDJG9UI6bT4SsXvqfcynhlpP//sS1+uSO2dyx5tJAQCFmnu6/OirFeL7++9REupjUqsh8upLO85zZoLN/ppxcS9M8SaAo/i46rsK/qfCUE+kFz8o+zLQBZvcMnWbik4rmrV6OfQLdQoQzb9cJSC3PlIGs7zly9MrrCgm43TJhb5KgDFGlbtv8TeEN2miZj8I0I5LQCyKe1Ch55ROtQHC6R6Y9pxhC4msVeRv0gkQ/F3+KhLzJSzWjuLxcD94RROE7cWnYIYsNr/IXTu7HyFvD3ATLdKtbqvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Crchb8muoi906WL7u5FUi723lBMUmuPLXb0uE5OJgw=;
 b=RpGkrZbpYGie/UPG0gFcN0q64y5GKDktEsQrqgWdvkRBFVxXUr734/VJeanDV5945BFmdptz/VfnNKuhi7DjbW/qRZVnfR57GyIlYiYH8oqf55TCRGuAucu9O8wWlXndBUSOdhhnfje6sARGGe38D7hWJzsMDnoXpFft7bMGXEHypDEVv2/O0z7+v3jiGDJIC8c2IcJRUKhaeVzQScK0dmy+ojSn2vfeW257IgNWTLERdRzh09wU3ELww7IjsvQFYS0zi4sEKbNQWGeMEj/I4PHYGY/qtFONAl3lIrTvvS3iW9fMvV22MUwdyb12nWTKVdNrNO+ENjXU/JPH35RSSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Crchb8muoi906WL7u5FUi723lBMUmuPLXb0uE5OJgw=;
 b=GJooOnRHM6kjP116N7+GqfAueEUV7ABeeEiP1t960y6Mq0GO97h+kJFikCvVCL9KzNvON0sh+4YUq+VAzVGLtCRN0nRHPH1obbG4hNNkc3i+uxT5hPtEWMdUpCUvoOfpRum5Lu2niqzMPay3rqxvv2zVnAwaavtuI+VpIQ5Qnh8=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5380.namprd12.prod.outlook.com (2603:10b6:208:314::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Tue, 11 Jan
 2022 20:21:16 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::99d4:4d4f:653f:61be]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::99d4:4d4f:653f:61be%4]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 20:21:16 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Sider, Graham" <Graham.Sider@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdkfd: Fix indentation on switch statement
Thread-Topic: [PATCH] drm/amdkfd: Fix indentation on switch statement
Thread-Index: AQHYByiifCNIU++lOkyiyBYcvNU66KxeQyHv
Date: Tue, 11 Jan 2022 20:21:16 +0000
Message-ID: <BL1PR12MB514467CB9C970DC6B56A9356F7519@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20220111201902.902923-1-Graham.Sider@amd.com>
In-Reply-To: <20220111201902.902923-1-Graham.Sider@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-11T20:21:15.653Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: 811a17bf-46d6-4a5d-9c4d-cb68d0ae4e37
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b509f814-c69e-4ea3-0586-08d9d53febaf
x-ms-traffictypediagnostic: BL1PR12MB5380:EE_
x-microsoft-antispam-prvs: <BL1PR12MB53803ABB651ADCAA22BE0CF7F7519@BL1PR12MB5380.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:541;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jco/uwOYJj9amxDD6GV8e0Lc8uzm6KUpZlKQWRoCMSW9JGXkgS7z6oUo4uZtWy3FMN21+zM6zgOj9K1i997dH1y9wBNDytgpjsff5XqZQQc8b8LjMeF9kF0qmNiQrSTtUpPcd1ZfG6tUG9lOuB1+N9f94C8YO3JKU5AUEF+SrGNQdWN+niJTqQSWLP6CHvu9DxJ1CZKsWAALNUzLpDuS7C7UChJDJuHeZeszrpVj/aGAexEZnlnipQOgndrEofwssV75l2bdT+eJwF6NPmcVpb9V9tbhFMSt3KBd22YSXaZ1un/tv8ID+HEkqISm6xt7tabHi9jMiEg//9D1sNKvr5+q8mhFTZAZB5WeKCXBOvX5pyhQ3W80YNRZ1U8MtSnoTAagAPKwAsjXzL5SWEu6x2hI5SiuQzCbMjh9olDO5m4vAJQhShLmvuZwSNtdwb1/dj03+WZktmgNt9UhUpOc2iF9lMc818uV8wNxg5U7AXE04RBjFExYvHb6/Xnlr6n1cFZhjjiY8Km1N1/2sz4zg1wJVBjaM54qnGDEvSDQBsoYPnY0FAAdudrgn0QFdsLZtKmh8o8PPjZ5w37OOzfeoL3YFcZUtFABUSgZLVCq18zpQJJgTCpY+sfMZnj/S29Ss1UqCrtVpR7ROgzNS2+9QzpAENbjwxoU6r7s/k22iNpsHnqf53qwHgCLj3Puy5Ji6E8X3SCJv0Fc2DHFtB4qQA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66556008)(76116006)(5660300002)(508600001)(9686003)(71200400001)(66476007)(38070700005)(316002)(52536014)(33656002)(66446008)(64756008)(8676002)(66946007)(8936002)(86362001)(110136005)(7696005)(55016003)(122000001)(186003)(38100700002)(53546011)(26005)(83380400001)(6506007)(19627405001)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?W2ow+xt8bw3McEUbBcl6EPQONncEl6WK0ihD0MsvsjYEnp7QW6D2ndM2qPZb?=
 =?us-ascii?Q?wHzmMbS24Obf2eSu8CPEeXWlAbR3kCnpNfjoLsHA6u4ipCXDizKHz4wtGxG8?=
 =?us-ascii?Q?5dxAgi63QQUS6XnGwnN/6yfTBrsnY26fT8NIjnwv/MG4ccmZ9duPlo2C6cXR?=
 =?us-ascii?Q?Jc/Jj3Pjd66Ee9n1itjsYO8XuVGr+dGkIkPsAbMSH3Uq3TwbAUxwtpoXRT7u?=
 =?us-ascii?Q?ebKU732zEPcL1TGYF1LcIo0Jx0ZXhsHkv8QK/an71j0wwYnFSABfk4zFdNbs?=
 =?us-ascii?Q?Sv2om+T2aG6Sr5U/bpH8iJ9S9OtRNoKcN5NiYRCYbEE0AC/9aMvj3umzzMX6?=
 =?us-ascii?Q?uMJSTrmdPhoELtNVoXvbyWyuXGq7beXrGKHZ0N+SJlkd3w4pdmstpzN4tVSj?=
 =?us-ascii?Q?jU3AUIfCE5+HGp1ZTvTqByV0ZuiMHlwxXoaQhx0J17bm5SdfDXsB/Ff+45Oi?=
 =?us-ascii?Q?vRb2H1FMyL7Gb/t9x3RLK1zJVoUHnJw11t4vYXxtXUSqPbmemfW8vEqMyCE5?=
 =?us-ascii?Q?I4JwcnFfN41HRQ2v1cr2CfuPvRzCliY5J4bDyv39TJ4Wfx2TCRpVTRPhkQOI?=
 =?us-ascii?Q?H3zNFKAN8CQYQ8fFEww6Tp/bSx3+kK8vFxBhjgFBNXBd8oWnsN0TJE6r1sm8?=
 =?us-ascii?Q?jPA6GS8VJ76CLiSslQiCJSRNCQ4o+Ez6eVRZNlnTJAO1uJOsmBlzvDWxjvyd?=
 =?us-ascii?Q?B4CwFS8VPoXHV2G+Oy3NskZ4KE+JANW4x4vBKSVNVeGpVmggQr8yV6Mb2yJJ?=
 =?us-ascii?Q?AqBK+a7aNj19efD3PqY5xk06cNAuZCkIkdxdA9hnOG5YQ7vayYO8St+jb8Mz?=
 =?us-ascii?Q?IYgWuXRRnFuWwlSsmn2pwTBOFcxTv5lA8qtkYXW3jc1UF0veXL5A22dEa8Ot?=
 =?us-ascii?Q?fXpra9Nr3PWs+NrmGcRI+lbJ0w3fXERlJr5c1a1ad5dsEqGIuXCkoN3BT+ED?=
 =?us-ascii?Q?PwpclrvgHy+geOD2iAyzzOSW31QaaTxQyyZZPaWRZ1iHKjF8Ns3AfdZjQIWi?=
 =?us-ascii?Q?7XQFkwinDoo1NzMEDXblBe0eaRe/pPS2cL/XllrR1O7x232EW757c7+3zXfz?=
 =?us-ascii?Q?08CVk0idkFiD8bMUAt2aGFk3uIQ9ldn3UAYaUkmUKDB+TZCKK1ETL/WJz0zZ?=
 =?us-ascii?Q?v7Lwb/xBKBoky7sbEHRvvyP0q7V4aVa21LbgtLdtToPekGr/+XMhx2saWWTc?=
 =?us-ascii?Q?pqYzuuybhWuve1weuHlSDuEJqrf6C5lqe/x7S5S2Fmgv2BhJD4mxsevHWPE/?=
 =?us-ascii?Q?tzGQ7DPRaCjAdeU+v7Z+hBvqDFI+OFnMMnUeksDhKuoY7PDIbtQ+2wBbKWGE?=
 =?us-ascii?Q?NtH+3ualduwHuzB87CU6HZQuszMjtPrpm3Zn1MHKGum/oRWDvmRJmGj6NdkE?=
 =?us-ascii?Q?lSaVMOyG8J2FGmgLRysW4QWLeW6jGceoNUKHkeZU38qWi13VFEZEpt6ZeFOJ?=
 =?us-ascii?Q?KA04QAhzX/4Fr4mQGmmIH76SxjtVoCQf/4vT5EV1jImFFO2rRt2JWm0yvkcG?=
 =?us-ascii?Q?PMBqy57AU0Dkj4l4aLJU6vKUpPpkkPzQE2Afem45yEwElGt2e0icklMCzLLV?=
 =?us-ascii?Q?sFP9BqTMz/wNMOSTobizfNA21t4XKlMNDcWctgEB635Uj2fLFa9QY6/SXMmM?=
 =?us-ascii?Q?PklZ7dKNK0hfq+xMtpKKM6E=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB514467CB9C970DC6B56A9356F7519BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b509f814-c69e-4ea3-0586-08d9d53febaf
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2022 20:21:16.2626 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N5ZtTxe2o0zcl7f50a8Ip/PQnecAeK3gW5rwlVokSa6THrW+TFwuk6kWBPhAfPdtvBsP7bX4sMrmSHXhQ6foNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5380
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

--_000_BL1PR12MB514467CB9C970DC6B56A9356F7519BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Graham S=
ider <Graham.Sider@amd.com>
Sent: Tuesday, January 11, 2022 3:19 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Sider, Graham <Graham.Sider@amd.com>
Subject: [PATCH] drm/amdkfd: Fix indentation on switch statement

Cases should be same indentation as switch. Also fix string spanning
across multiple lines.

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 55 ++++++++++++-------------
 1 file changed, 27 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/=
amdkfd/kfd_device.c
index 2b65d0acae2c..5a47f437b455 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -64,34 +64,33 @@ static void kfd_device_info_set_sdma_queue_num(struct k=
fd_dev *kfd)
         uint32_t sdma_version =3D kfd->adev->ip_versions[SDMA0_HWIP][0];

         switch (sdma_version) {
-               case IP_VERSION(4, 0, 0):/* VEGA10 */
-               case IP_VERSION(4, 0, 1):/* VEGA12 */
-               case IP_VERSION(4, 1, 0):/* RAVEN */
-               case IP_VERSION(4, 1, 1):/* RAVEN */
-               case IP_VERSION(4, 1, 2):/* RENOIR */
-               case IP_VERSION(5, 2, 1):/* VANGOGH */
-               case IP_VERSION(5, 2, 3):/* YELLOW_CARP */
-                       kfd->device_info.num_sdma_queues_per_engine =3D 2;
-                       break;
-               case IP_VERSION(4, 2, 0):/* VEGA20 */
-               case IP_VERSION(4, 2, 2):/* ARCTURUS */
-               case IP_VERSION(4, 4, 0):/* ALDEBARAN */
-               case IP_VERSION(5, 0, 0):/* NAVI10 */
-               case IP_VERSION(5, 0, 1):/* CYAN_SKILLFISH */
-               case IP_VERSION(5, 0, 2):/* NAVI14 */
-               case IP_VERSION(5, 0, 5):/* NAVI12 */
-               case IP_VERSION(5, 2, 0):/* SIENNA_CICHLID */
-               case IP_VERSION(5, 2, 2):/* NAVY_FLOUNDER */
-               case IP_VERSION(5, 2, 4):/* DIMGREY_CAVEFISH */
-               case IP_VERSION(5, 2, 5):/* BEIGE_GOBY */
-                       kfd->device_info.num_sdma_queues_per_engine =3D 8;
-                       break;
-               default:
-                       dev_warn(kfd_device,
-                               "Default sdma queue per engine(8) is set du=
e to "
-                               "mismatch of sdma ip block(SDMA_HWIP:0x%x).=
\n",
-                                sdma_version);
-                       kfd->device_info.num_sdma_queues_per_engine =3D 8;
+       case IP_VERSION(4, 0, 0):/* VEGA10 */
+       case IP_VERSION(4, 0, 1):/* VEGA12 */
+       case IP_VERSION(4, 1, 0):/* RAVEN */
+       case IP_VERSION(4, 1, 1):/* RAVEN */
+       case IP_VERSION(4, 1, 2):/* RENOIR */
+       case IP_VERSION(5, 2, 1):/* VANGOGH */
+       case IP_VERSION(5, 2, 3):/* YELLOW_CARP */
+               kfd->device_info.num_sdma_queues_per_engine =3D 2;
+               break;
+       case IP_VERSION(4, 2, 0):/* VEGA20 */
+       case IP_VERSION(4, 2, 2):/* ARCTURUS */
+       case IP_VERSION(4, 4, 0):/* ALDEBARAN */
+       case IP_VERSION(5, 0, 0):/* NAVI10 */
+       case IP_VERSION(5, 0, 1):/* CYAN_SKILLFISH */
+       case IP_VERSION(5, 0, 2):/* NAVI14 */
+       case IP_VERSION(5, 0, 5):/* NAVI12 */
+       case IP_VERSION(5, 2, 0):/* SIENNA_CICHLID */
+       case IP_VERSION(5, 2, 2):/* NAVY_FLOUNDER */
+       case IP_VERSION(5, 2, 4):/* DIMGREY_CAVEFISH */
+       case IP_VERSION(5, 2, 5):/* BEIGE_GOBY */
+               kfd->device_info.num_sdma_queues_per_engine =3D 8;
+               break;
+       default:
+               dev_warn(kfd_device,
+                       "Default sdma queue per engine(8) is set due to mis=
match of sdma ip block(SDMA_HWIP:0x%x).\n",
+                       sdma_version);
+               kfd->device_info.num_sdma_queues_per_engine =3D 8;
         }
 }

--
2.25.1


--_000_BL1PR12MB514467CB9C970DC6B56A9356F7519BL1PR12MB5144namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Graham Sider &lt;Graham.Sider=
@amd.com&gt;<br>
<b>Sent:</b> Tuesday, January 11, 2022 3:19 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Sider, Graham &lt;Graham.Sider@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdkfd: Fix indentation on switch statement</fo=
nt>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Cases should be same indentation as switch. Also f=
ix string spanning<br>
across multiple lines.<br>
<br>
Signed-off-by: Graham Sider &lt;Graham.Sider@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_device.c | 55 ++++++++++++------------=
-<br>
&nbsp;1 file changed, 27 insertions(+), 28 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/=
amdkfd/kfd_device.c<br>
index 2b65d0acae2c..5a47f437b455 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br>
@@ -64,34 +64,33 @@ static void kfd_device_info_set_sdma_queue_num(struct k=
fd_dev *kfd)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sdma_version =3D =
kfd-&gt;adev-&gt;ip_versions[SDMA0_HWIP][0];<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (sdma_version) {<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case IP_VERSION(4, 0, 0):/* VEGA10 */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case IP_VERSION(4, 0, 1):/* VEGA12 */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case IP_VERSION(4, 1, 0):/* RAVEN */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case IP_VERSION(4, 1, 1):/* RAVEN */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case IP_VERSION(4, 1, 2):/* RENOIR */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case IP_VERSION(5, 2, 1):/* VANGOGH */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case IP_VERSION(5, 2, 3):/* YELLOW_CARP */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd-&gt;device_i=
nfo.num_sdma_queues_per_engine =3D 2;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case IP_VERSION(4, 2, 0):/* VEGA20 */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case IP_VERSION(4, 2, 2):/* ARCTURUS */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case IP_VERSION(4, 4, 0):/* ALDEBARAN */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case IP_VERSION(5, 0, 0):/* NAVI10 */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case IP_VERSION(5, 0, 1):/* CYAN_SKILLFISH */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case IP_VERSION(5, 0, 2):/* NAVI14 */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case IP_VERSION(5, 0, 5):/* NAVI12 */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case IP_VERSION(5, 2, 0):/* SIENNA_CICHLID */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case IP_VERSION(5, 2, 2):/* NAVY_FLOUNDER */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case IP_VERSION(5, 2, 4):/* DIMGREY_CAVEFISH */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case IP_VERSION(5, 2, 5):/* BEIGE_GOBY */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd-&gt;device_i=
nfo.num_sdma_queues_per_engine =3D 8;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; default:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_warn(kfd_dev=
ice,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Default sdma queue per engine(8) is s=
et due to &quot;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;mismatch of sdma ip block(SDMA_HWIP:0=
x%x).\n&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdma_version);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd-&gt;device_i=
nfo.num_sdma_queues_per_engine =3D 8;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(4, 0, 0):/* VEGA10 */=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(4, 0, 1):/* VEGA12 */=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(4, 1, 0):/* RAVEN */<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(4, 1, 1):/* RAVEN */<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(4, 1, 2):/* RENOIR */=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(5, 2, 1):/* VANGOGH *=
/<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(5, 2, 3):/* YELLOW_CA=
RP */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; kfd-&gt;device_info.num_sdma_queues_per_engine =3D 2;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(4, 2, 0):/* VEGA20 */=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(4, 2, 2):/* ARCTURUS =
*/<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(4, 4, 0):/* ALDEBARAN=
 */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(5, 0, 0):/* NAVI10 */=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(5, 0, 1):/* CYAN_SKIL=
LFISH */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(5, 0, 2):/* NAVI14 */=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(5, 0, 5):/* NAVI12 */=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(5, 2, 0):/* SIENNA_CI=
CHLID */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(5, 2, 2):/* NAVY_FLOU=
NDER */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(5, 2, 4):/* DIMGREY_C=
AVEFISH */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(5, 2, 5):/* BEIGE_GOB=
Y */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; kfd-&gt;device_info.num_sdma_queues_per_engine =3D 8;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_warn(kfd_device,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Default sd=
ma queue per engine(8) is set due to mismatch of sdma ip block(SDMA_HWIP:0x=
%x).\n&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdma_version);<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; kfd-&gt;device_info.num_sdma_queues_per_engine =3D 8;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;}<br>
&nbsp;<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB514467CB9C970DC6B56A9356F7519BL1PR12MB5144namp_--
