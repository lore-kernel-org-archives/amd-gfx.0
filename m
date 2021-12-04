Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01F06C433F5
	for <amd-gfx@archiver.kernel.org>; Sat,  4 Dec 2021 02:37:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 137F7AB505;
	Sat,  4 Dec 2021 02:37:41 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE684AB505
 for <amd-gfx@lists.freedesktop.org>; Sat,  4 Dec 2021 02:37:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IN2sMVSPrB3GSuyPpQ3Oai+M7PkjSloykcpdROI1oIam3uEc/65uI+Eb1bLFeX1ASxf2D5uiaCrFui6Euvxggbi5gqZgLaWr3xr5c+uZRkDY5AVcbh3f3BjJpOPd7VFfoFIRqHSGF67F9iawcLlvGx4YQSh+nPgMTIza9pe0YuvwLi26sqOhVw0gGvVcEZOXO1Ai9cNyomakoJQz6SuoqKRCAqjJrcikxJkWhJLj9bmht8IRZefdgm7y64j3nhmJZ30tRV7wLcVKanKv16smldJEIEerYwjHK2+PAkH65pCPuvU33viCxCl/59AcW3nIB43Nu0qCtm8iRYDxpdfs7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yul7LB17a/LIK0RMwUtUcpYP2wZS3LKHQLgehxjEOIQ=;
 b=T7/r1qYpQP3KgSS2rTosNE07jMXE3DfdQPd5b7vehDNSuWnndbm8o7i62VdaprNXYYLYy/JiUS8kH2HM44nFwbvfugtdEz6VWJWYXoNE1GHRjz4MqQSAkdEk8wr0MN6lRkK9RyxkyVPs4N+rsT2wRGd/zp+B7gwLZQFLGXmAEAF/bKx9VXx15Nwy2rJp7tcgJ2/DNIRiyXpudRrjN8AdmX7Y+QI8hvOzjbug87zNlTUU5n0xcwzDPxU1GI6XpT3eXSggr+0tcNKnaGBTQDzoDChLel/QlEsmG3dSYVuuVUFcdK3SqgBLInReTgp7CS2Af4mMu8+tOkMiibl1YO5S2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yul7LB17a/LIK0RMwUtUcpYP2wZS3LKHQLgehxjEOIQ=;
 b=xBoJunOSpXM7i8gozWDaNpUfDyewRhwakEIffenblhHcko+ReU2FSPb6f743B+HjMcK7XFnny619OwltjLb/Wg8ddvBi05rdZ8ZTmqp9EM9luPVYMeNXVXNSRR5v1MS1Ni30w3CHRLxvm3B5hAVVADR2TpwU+iqN8C1NIZB7Ohg=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by CH0PR12MB5385.namprd12.prod.outlook.com (2603:10b6:610:d4::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Sat, 4 Dec
 2021 02:37:36 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::31b4:ebc:1707:f563]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::31b4:ebc:1707:f563%6]) with mapi id 15.20.4734.024; Sat, 4 Dec 2021
 02:37:36 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Luo, Zhigang" <Zhigang.Luo@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: skip reset other device in the same hive if
 it's sriov vf
Thread-Topic: [PATCH] drm/amdgpu: skip reset other device in the same hive if
 it's sriov vf
Thread-Index: AQHX6JQZ3Zquk8TCFUGrUA3bGGXkdawhmKRA
Date: Sat, 4 Dec 2021 02:37:36 +0000
Message-ID: <CH0PR12MB5372DAD8940E7F19741338EBF46B9@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20211203220543.29433-1-zhigang.luo@amd.com>
In-Reply-To: <20211203220543.29433-1-zhigang.luo@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-04T02:37:34Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=1f4e45ca-b17a-44b7-a76b-f2ffe7ec4776;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2021-12-04T02:37:34Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 08d3ff27-d7c5-4112-8f6a-1ce419f2d0ec
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a10e7b7c-37e8-4669-e7f9-08d9b6cf0874
x-ms-traffictypediagnostic: CH0PR12MB5385:
x-microsoft-antispam-prvs: <CH0PR12MB53859075C04DAF2F33EF54D5F46B9@CH0PR12MB5385.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 74PsLeVjI4hglF3uCOlKrJPlx8arKsUDLz40eBZss1pWjbzH8lt2jbuVDxbWYR74jdxtjDBS5jd6GjG8V+qocm1LcuID5r8Vme6OraYK04u+55Qu/fuygk7+fs2YI2XwASXObWOIJqYepWL7ozc2d1JKZRhqEFjh7k/nbkzPRRrCFNB4Bn5uyXqMntZsDASZOVma0FdpL3Y6Iu12ZnuPFZoiCyL9EgfaPXmyPPqTxdZsW/6MP9HQS09J///HUTi3SjRoZeTzubxKbZ3nKj7FZQ3uP387Lw8LiwbvX3Ty50qyhW7HwtMIhT2vnfFpb+DlJ4L5VU3lU3OegSBAnMSpL37LfI5U8vuTXqqNaAH+c0k1Ohmw7yY0nq7gt5Qo4VG5iuuRJmd5Iu65pudpBHMYRSMCbbA9t5dgI6ZUL35Aln2rs2Ql+iOAOba5iVCPc8gw6qHOISIPj7SC757u7LgxiFQ23Fl4VOmMzxcOO2WAZ3ZnmK5mrWQXezUpUORZF1La2/V4cC8D6RKBYuuYMTYnnHdr9fWxbTpEGVPmnzosqquU0TeKT0pbHgvJsD23VKTzg3jrXJGR0jHhaR2yPXXtX/vPFI+OJ/cO2yAZB96QjPU2+L+Zq/NzmKzwPZx6IGD9n08Rw0IYFgL1pRD0QB0Vy8UbaDo49DrXMJLbe5fj99/NiIsKf8AAtozw8ql4Z06Y2KdzmzIkcB3CmMMOVPDARQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2906002)(26005)(5660300002)(7696005)(83380400001)(316002)(52536014)(508600001)(122000001)(38100700002)(9686003)(66556008)(71200400001)(76116006)(33656002)(66446008)(55016003)(66476007)(4326008)(64756008)(110136005)(8676002)(186003)(66946007)(86362001)(6506007)(38070700005)(8936002)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gelpUoszciEY4P6r/zhhphOb4h5f6bCqhMZIVKxWyuLFQ0IUoq8gUiukyyh8?=
 =?us-ascii?Q?QHQWKFfxko87Taeg4xu8W3MnTgci3BR8N6V81itwztOoUD6rpC9aQRdr5yfZ?=
 =?us-ascii?Q?+7OiSWbyJ4droeGii4J0jKYaMQxtysa4qOIZA93z9ZexFSyRaUNkS11ruywX?=
 =?us-ascii?Q?VP4EWnJPTvTyi0hdkcNsKSwuWoYKku9FbpDpiXkxCRJnfD7jSiLA5xMOpj6d?=
 =?us-ascii?Q?1HtiD6I64AngBBL94lzRHZPYOItSJ1AisqH5dlItjHlCkWlfOG0jmFLzeg6E?=
 =?us-ascii?Q?lJAsRrJYVIuXJCEt04BjbGEJONImiOL9d65j3UpYWkROgVNQ16RNusb91IEz?=
 =?us-ascii?Q?S0/aacN7eywIO4k/QLFdQUFkmbQQixhmMmJH9BbG0jWISocBi81Hlnq5tHiq?=
 =?us-ascii?Q?I4w+FbXO2HiooZQUM6C6/fktQ80HfVYlm9mvrYxTMBh/ulhf7RrheFyc3iOG?=
 =?us-ascii?Q?cej1dXuIGNn0Ex01GWsYJsT4CufZrjMk7/XO7SpVZAHtbdx+MndLA4QQpz4K?=
 =?us-ascii?Q?b4z+8hY3FzmJkyoaUvTlwaBb5qcMASwtRMUd/IuC/6toQUt16K8AABPUQKBD?=
 =?us-ascii?Q?tmUMdevbdKhPXS/Wb4wfoXocgwPyg1NhEkLnvaz1YjgqM3wSlCT8VPMfzny8?=
 =?us-ascii?Q?iJkCl5dTYzpfKSdlQLOAW8oNq9Yhz46Iosz9EMnwtBR2M1k/ci9jcHacIhqA?=
 =?us-ascii?Q?NF7THGle6dF2mdzJCxMsnDxu/bHYxcK0Zi/m7v/vgvJoGG4ZKuH5yiaLv/qM?=
 =?us-ascii?Q?4+u9nRlW5jznRm6ieVnayuAjbW08zXC36NPKf0NYBm3Q3ZgLeLB50dteX1iw?=
 =?us-ascii?Q?MoBnK1T+gEvOCRZMGsLdKEBiIwfHt+VUSReAOs//+LC/9Tj5bOcCF2f7Yu/0?=
 =?us-ascii?Q?SoeoGRzrrVkUVu/xNCoepd7dtA9QYTJhK3jAWHsppikj3XnRry0cfq88JgBW?=
 =?us-ascii?Q?MO/gu+U7iooHvzLUYSdO83CbXj9sFB3vE04w3+25YoPIoj4qQmCTNNYmnEbI?=
 =?us-ascii?Q?KFLgvLCFPRzQQBuggNXssIuBo4DXdKgATft6tO6+E1oGn5X5ZERtMo4px/pd?=
 =?us-ascii?Q?gfu7LyO4+lx8CUVvuDiapzyODFao/06Ydtg6PaQTUyYIcxcrCbAOrNgcgNQn?=
 =?us-ascii?Q?Ar5LlXvNKQKPIMN2IEVnyCsYe9CCUXDUH6e4vM8KvHM1dU453gmQg7aWx8hN?=
 =?us-ascii?Q?dB00uNvPmvfG6Y0ObpSHfxHRtWfBytQtmfh8r6ESEE5xtOHCpR5IPS488+Wt?=
 =?us-ascii?Q?W8d4GVghhZw2z9HeDDE/BuFqx8duZGv4daMhzlcDcgbt3d89Abivc/3gFlfO?=
 =?us-ascii?Q?9FLNBe1VO5ZlmY8s+cZwAYqimfapqlpZkdYilGeIhfuIeIKkALbLau++gdJf?=
 =?us-ascii?Q?DkvnZXCxQyAAT+plL/SKWQEzCbFip9D4995XcRlcnw3a/2rhyDp7c9OjZW+J?=
 =?us-ascii?Q?9RzTIklMLCZyJGAnXe34jqG7F8hdacHiUgQYnjuWhc0oO3J/0suCkdSjyXpb?=
 =?us-ascii?Q?gnCipNKbsOj0x58hkJf6L/UOUVxSERXN9WckArn9MTwSzniol+so/QykvLK7?=
 =?us-ascii?Q?bhR1q8IvBmkvna8VDUz1bvYLgsxqLgoMNlrupcujaDR11JQavZcmMloKXd77?=
 =?us-ascii?Q?+fv3cXcmMTkPdJcIfmnu9+o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a10e7b7c-37e8-4669-e7f9-08d9b6cf0874
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2021 02:37:36.2197 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: owUCSeX6JSNFKkbkc9vp2NgFnsn/fYxSEmFYsoyFfp29kteh/5rPeiU3eJkepsuPX9kL+JzAZfa7IGcJ1RXffw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5385
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
Cc: "Luo, Zhigang" <Zhigang.Luo@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

I think you need to describe more details on why the  hive reset on guest s=
ide is not necessary and  how host and guest driver will work  together to =
handle the hive  reset . You should have  2 patches together as a serials  =
to handle the FLR and  mode 1 reset on XGMI configuration. =20
The describe is something  like :
  On SRIOV, host driver can support FLR(function level reset) on individual=
 VF within the hive which might bring the individual device back to normal =
 without the necessary to execute the  hive reset.  If the FLR failed , hos=
t driver will trigger the hive reset , each guest VF will get reset notific=
ation before the real hive  reset been  executed . The VF device can handle=
 the reset request individually in it's reset work handler .=20

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Zhigang =
Luo
Sent: Friday, December 3, 2021 5:06 PM
To: amd-gfx@lists.freedesktop.org
Cc: Luo, Zhigang <Zhigang.Luo@amd.com>
Subject: [PATCH] drm/amdgpu: skip reset other device in the same hive if it=
's sriov vf

For sriov vf hang, vf flr will be triggered. Hive reset is not needed.

Signed-off-by: Zhigang Luo <zhigang.luo@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 3c5afa45173c..474f8ea58aa5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4746,7 +4746,7 @@ static int amdgpu_device_lock_hive_adev(struct amdgpu=
_device *adev, struct amdgp  {
 	struct amdgpu_device *tmp_adev =3D NULL;
=20
-	if (adev->gmc.xgmi.num_physical_nodes > 1) {
+	if (!amdgpu_sriov_vf(adev) && (adev->gmc.xgmi.num_physical_nodes > 1))=20
+{
 		if (!hive) {
 			dev_err(adev->dev, "Hive is NULL while device has multiple xgmi nodes")=
;
 			return -ENODEV;
@@ -4958,7 +4958,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *a=
dev,
 	 * We always reset all schedulers for device and all devices for XGMI
 	 * hive so that should take care of them too.
 	 */
-	hive =3D amdgpu_get_xgmi_hive(adev);
+	if (!amdgpu_sriov_vf(adev))
+		hive =3D amdgpu_get_xgmi_hive(adev);
 	if (hive) {
 		if (atomic_cmpxchg(&hive->in_reset, 0, 1) !=3D 0) {
 			DRM_INFO("Bailing on TDR for s_job:%llx, hive: %llx as another already =
in progress", @@ -4999,7 +5000,7 @@ int amdgpu_device_gpu_recover(struct am=
dgpu_device *adev,
 	 * to put adev in the 1st position.
 	 */
 	INIT_LIST_HEAD(&device_list);
-	if (adev->gmc.xgmi.num_physical_nodes > 1) {
+	if (!amdgpu_sriov_vf(adev) && (adev->gmc.xgmi.num_physical_nodes > 1))=20
+{
 		list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head)
 			list_add_tail(&tmp_adev->reset_list, &device_list);
 		if (!list_is_first(&adev->reset_list, &device_list))
--
2.17.1
