Return-Path: <SRS0=SWRn=ML=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DBBBC07E9B
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jul 2021 13:48:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37E6E61073
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jul 2021 13:48:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37E6E61073
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA2DD89CDD;
	Mon, 19 Jul 2021 13:48:43 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37D8189CDD
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jul 2021 13:48:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LKmCVmr2VlZNJ4pyKWFKvsHbdol9SNAs+g6s89pOOvq2wbVX9hJ5QQKaq6pfcDTXAYcXoZ59Du0uJT/aEvY/LqJgsNcpOGITd9aFyNyhBF5MYvQLthFzir5O3Xww+jbJacWlcjBVu08tR1LvXtFRJg10QZWywtCf2Dsh/xiJwNLvP95ZUGbLUjKiJ7aVl31mbNXEmOG/egAX8RSxsrcGo2pOkE8USmmWM0Er0myObmFeg/lycl5NIrtff2WonqYK4clsqGVQ1uYwmtLqFqmBrdxq/pKCb1yc+7J010x8elxvfahA4MIr4jh4ktFgGgonC7inoi/KSg6gpvEqhZSbvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f8j5oRc6qKd6pCgTujE1t+PyxF0FBqCMtMdegnNG5Jw=;
 b=eZZWpjtu+qnkR7+h2XMNFn4vb4caI8lUHUyTf/Zk97JUmskxJTLY54H3xn9CzHb72yU0zSLUE1SLh1Y45n1ze1DnC5KBY50o+qMs6DO0dtbO10PlQihYrWY5Y4TtuQY1yhuBeCGNP6nCGm37DGYCooe7WyFSPjwmc49pnOXc/ClVoZ8E7+C/KmGQXaGaAEoXgyyqd7w0WAX6OWMCltF03WIc/c7yo7w0VMMpL9hZzWV3Q7EwgggfRSxN4S9Y2Fyv9GKKF3yW2qBPQW2jZnrP9PiOjgO34uXUXP0r0TgYyDl8C3f88QcqNmVTVq9r9RH2y4B32K5G8F8/hxipxNynlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f8j5oRc6qKd6pCgTujE1t+PyxF0FBqCMtMdegnNG5Jw=;
 b=XGmo3n8IXebVFLccDypdD4SpL5DuMtGcR4Xs2XIDyu3bJeyvSkqMmot7/gBN7zOfzbnw2PzXmlYv92dX41UTkhXWFk4XQ5eun2R6hovgecvCvIOQyR/CMW+dtdy5k/+qVKDGJfDxq/LAggDZMEK6/0vuixUT2yxjZqlVdrFlB6U=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM5PR1201MB0027.namprd12.prod.outlook.com (2603:10b6:4:59::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.24; Mon, 19 Jul 2021 13:48:37 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::453c:6ded:8973:744e]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::453c:6ded:8973:744e%4]) with mapi id 15.20.4331.033; Mon, 19 Jul 2021
 13:48:37 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Gopalakrishnan, Veerabadhran (Veera)"
 <Veerabadhran.Gopalakrishnan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu - Corrected the video codecs array name for
 yellow carp
Thread-Topic: [PATCH] drm/amdgpu - Corrected the video codecs array name for
 yellow carp
Thread-Index: AQHXfKN1+qCX+LmZuESjpoEYf/aNlqtKUAmA
Date: Mon, 19 Jul 2021 13:48:37 +0000
Message-ID: <DM5PR12MB246905D2EB5546B672A51F0FF1E19@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20210719133838.100107-1-veerabadhran.gopalakrishnan@amd.com>
In-Reply-To: <20210719133838.100107-1-veerabadhran.gopalakrishnan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-07-19T13:48:33Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=e2dea944-66f9-4be1-8653-f2b5b4c5fb5b;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9d8b1b7e-1035-4de3-76b7-08d94abbe8f4
x-ms-traffictypediagnostic: DM5PR1201MB0027:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB00275955208BA233DBFA0F51F1E19@DM5PR1201MB0027.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X3S7GUnKVLEI6I3ZEvs64/673x0UbF2IyHLBNyhWreMQsTQho5LDLj3fCGGKPI+T7RktdBGH+H7rwN3v97j3IpOKll6RRWyd1WFAJsOW5mOCWSRcXK1MTXgScx8kIDdLxfkEvlEiE9e/QV9r523WfRTXE9SB6wVBXkjk51wSygP6AerXxxiXeYrEg2wUJDdnMD9XMtvpSYq0HWiFDWrGpqjCPsmZxPzBwSq/Bw4hDjUCS7uIlGEO6GqSVbFr1MsHmXrHyF8NcbTU8bPucZRzb874jDU3POQXKetKQ0ZjN+EsXNGMlrZ4AuqoJXLF43n7NVKkgv4x7gbDYiTiMs0s6vLKnKfVYYIKDLXrb9qvcTci2nHDOT13NUKfs+4lK8XPW5FlIq8vCwC5InRmFnHxk7YDoQlCHQZDYYFp2DmeRRkAfVH/TO6EeSPutrrPoL+pL/vWGxnIuHPMgSfq5lwz16R2lPpiLiIC0hS3AmB1bqJ9L7VATsuwQ5nq3wRFAMWEMEmT6J7lUd/vI2jUL5ZMSZe0WccSzNR+tka2OVhYZnfuXe/E+8I9szFiiBLZth5GVpc6JZKNR8Yl6XG6yshPw6omxMZr82EsSHd3sqq9/Vwo2kd+ko143yQ+Vtch05dP6hWY2cSdomKwIwdUe7UE2ETWWdJD1IHRGVjhutbyPIMLeKUMXkVWkwQizAWiTRbLbgBjiElgQ+l04wr5pLakdmEMk/5jpJApt+Hnb/hs28I=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(346002)(366004)(136003)(39860400002)(71200400001)(122000001)(45080400002)(6506007)(53546011)(4326008)(83380400001)(110136005)(54906003)(26005)(7696005)(966005)(38100700002)(186003)(5660300002)(52536014)(316002)(8936002)(33656002)(55016002)(9686003)(66946007)(2906002)(66446008)(478600001)(76116006)(66476007)(86362001)(8676002)(66556008)(64756008)(21314003)(38070700004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?N36Oqc0q8nBMPrUTxA0sIPGU/zyMdCI01qdJdolsk4+Ml/GdTRgJ50IB+9YX?=
 =?us-ascii?Q?2iPWFJrjxYfxZlyKC1cJ24OFZoiFLz9bmYQnHcPE3eO9Z9egyKIRLMdSBSLF?=
 =?us-ascii?Q?kknfe6AXzPFN71gT+wJ1gMY3vLvnyHpADNIDgvDXl51KHSuJyTLJl0tSJXes?=
 =?us-ascii?Q?GB0HItMQKZhsZ8HliriwDQ91xX7+H6brwyHMRcqJgdt4ju718odxmt4MrWDb?=
 =?us-ascii?Q?FsjYYjSuLL2I2/GOBVIDxJdO7GPFpolYTEvcCVCkbd/mqv2mRcsGqs9kuZdC?=
 =?us-ascii?Q?ak/AJ4ZB1STuas7uw2cVH2IzvunIKD2dE/FUELwoHUi0d3bg9UN+ntzIdsEe?=
 =?us-ascii?Q?2tVF3IylBCosFsf8gRYRBY0fmbJ8PfK9FTELtzXu9iAZqhsxYATntidNUifv?=
 =?us-ascii?Q?kHf2Fy3ONutnnYRHcEvVxmXoZtp2GwrwyHvyigjc3aN7zVnWZcHdSALdKT+Z?=
 =?us-ascii?Q?ylZTCN6l6DO82KRqVQl/jflgMQyOdUUbfxM9PCw9R3LuThQmiLYv+JwZxxwx?=
 =?us-ascii?Q?Lo6kKMPcGS9C0os2xT266csvX8CGEulnl1uF//5mVCG7gS/JqEVKPasdh2yd?=
 =?us-ascii?Q?jQ9a+fOsJiQNo/+tqYw8pElM0QafZoXrcWiyNo2tApg3kmzDrWjIXTbgrM8w?=
 =?us-ascii?Q?89V7uto1g8bM7G+l8VQDC/rbGSwZoE3M+mDnz+C6Nx+k8cHNuX9gOx3L3qFz?=
 =?us-ascii?Q?z+qMrH5yzeCtKC6HYvReStb1EDRCQ9oVLBcNLXfOq6Rhx7KdwhurnKrRlv2q?=
 =?us-ascii?Q?p8FMe00agzg9dwTZ66fU6HzuRT1ly3zB2KyxKg+IGaOiVmEDSGVbG0kjZPqn?=
 =?us-ascii?Q?fWZIiIyZX0MFJofS4IhvkqZOE1kvAJ4a72f890Hta+xojD0CW9JdOUbv6jJr?=
 =?us-ascii?Q?I4GTh74Zw7mJwCNSZnElxBUSWpWhR+dOp0OLnJO/Y6+MW4qnG2KcYnc9Whzk?=
 =?us-ascii?Q?izXOptOgriK5CByPNCfvpQynKYXAtJKCGKhEFn4dpgbSJwHNIAHE/K572+ua?=
 =?us-ascii?Q?15vhTMOK7EJtzX/ZX48A50O86xsPi+fCrf27axH2zXS1CvZGkLsKsyThngN6?=
 =?us-ascii?Q?rJEYeMF1qRU236Qc2GDT31bjn6fuFurv3qUaZ6bqd8Z4mMr+HqeqZ5mOGVOo?=
 =?us-ascii?Q?8tc2Y4bW0eOpTRsMNNEZqGKyrZYhYWj3FBrQkZluqlRi5FsdD2T/y5kHkJF+?=
 =?us-ascii?Q?EoL1dkSiK1VFTt8x4Axvy7yJJQOHk+xpD2vHblnGmZkrjbb4e9RnWjB/M3wQ?=
 =?us-ascii?Q?XSRFJlyutcSJNKYSikqHg8ny6UHobJZka/lq7MrqhDdBccjueoMQCSZc43t6?=
 =?us-ascii?Q?Ga97ldMHWNIDiezYHqKW9mHZ?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d8b1b7e-1035-4de3-76b7-08d94abbe8f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2021 13:48:37.5901 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K4D2GUkBNQbxL6OR+OqfRhV7PFktlU7vw9MmQPmjE4LG34W0wzSuLpiNiSSOkumFP5gaBd5MeEiM32kHbStB3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0027
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
Cc: "Rao, Srinath" <Srinath.rao@amd.com>, "Zhang,
 Boyuan" <Boyuan.Zhang@amd.com>, "Zhu, James" <James.Zhu@amd.com>, "Liu,
 Leo" <Leo.Liu@amd.com>, "Gopalakrishnan, Veerabadhran
 \(Veera\)" <Veerabadhran.Gopalakrishnan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

.codec_count = ARRAY_SIZE(bg_video_codecs_decode_array),

You need to change bg_xxx to yc_xxx as well.

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of veerabadhran.gopalakrishnan@amd.com
Sent: Monday, July 19, 2021 9:39 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Boyuan <Boyuan.Zhang@amd.com>; Gopalakrishnan, Veerabadhran (Veera) <Veerabadhran.Gopalakrishnan@amd.com>; Zhu, James <James.Zhu@amd.com>; Liu, Leo <Leo.Liu@amd.com>; Rao, Srinath <Srinath.rao@amd.com>
Subject: [PATCH] drm/amdgpu - Corrected the video codecs array name for yellow carp

From: Veerabadhran Gopalakrishnan <veerabadhran.gopalakrishnan@amd.com>

Signed-off-by: Veerabadhran Gopalakrishnan <veerabadhran.gopalakrishnan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c index cf73a6923..3027b44df 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -174,7 +174,7 @@ static const struct amdgpu_video_codec_info yc_video_codecs_decode_array[] = {
 
 static const struct amdgpu_video_codecs yc_video_codecs_decode = {
 	.codec_count = ARRAY_SIZE(bg_video_codecs_decode_array),
-	.codec_array = bg_video_codecs_decode_array,
+	.codec_array = yc_video_codecs_decode_array,
 };
 
 static int nv_query_video_codecs(struct amdgpu_device *adev, bool encode,
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cguchun.chen%40amd.com%7C5eeeb3a77fad4647678008d94aba9688%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637622987531891570%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=DI5h9oLQdSykmLEUgDXoobouTACHLMk99hnP92udTMo%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
