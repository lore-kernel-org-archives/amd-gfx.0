Return-Path: <SRS0=AQd/=IN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A3A0C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 14:42:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03AD364E31
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 14:42:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03AD364E31
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E8AF89B11;
	Mon, 15 Mar 2021 14:42:02 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D92E89B11
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Mar 2021 14:42:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B3gdxoY4qA34ZCEkbnUcwS0bBzPxmgz2Rrahb3p5jmX/pXRsczeKc8eZAqAD1pr+tEVNwlT9WwZNW8e3YfmhuyVH1GofznjsYpKXmAhwDVl90YlXo9rSeW5tmo/REC95NYcgHDFCGoOQxAynxOAp+45qkHvFIrbLqwZhHA9rJP70BBAwi4ZjJSOh+NUiZ4EEq8V3axvoIAHi1158/+khXf5vTF+P/L3nMvSHYZbBb16p5z+HdAGOv7fdJe53C3YVAqkQ3EgUl3Oid8oJX1bUhdtRuW4fTYIT75xmThiTFtuvwQSvbDUZ3Q6jQ62UsM6BlADXbIdVSRe/KgCPuHwTLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VGwfrUYVH60yfevw7Cm7+ZPvQttczuGmxjJ0qy/n6IE=;
 b=hFwzrJhIIQ2658iDldAkrBq8y5EZNY2soJhLJT9tlGSl0lItCm1+6YGYbOEnk+lxMPijdSKpispAscZlst1hZkYsAZZES+0lPaVUgCNWy0XHesJpQGwka6yaO6lG9Zmdzgks6XMGMkDTRXFDzk6KwkHIRXcBsjJ4j2d6iKmscaHFw4ambe72SIUmGPhAu6c1N50sEUEvAtN/Jdz0fpblh3tPC/Rw/arFmmq1I6It4p6j6LeeXOa5ERniwymrxHG9fDYACZNBIIUoDMNeLUrS9XxYhKGc2JLo+zwicqhdcJxSE4DF90v8gmxHid2GZtcyq6IjjVxS1wAy5avx3HHucw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VGwfrUYVH60yfevw7Cm7+ZPvQttczuGmxjJ0qy/n6IE=;
 b=1UkDrX8JbrgGXxy3VBAUzLiriYUENoJ63O9zqLD0z1frsgLK+9i7OAdFqJeB0b9GOHoTEKhLPpzEDqFa92FRi7QL3n7qnmSA0OQS7m92BtcFhkiGNL7KlMPwrdsz7F2HEo++IltnDaeyFzFqRIN+36X22/vYRt8XfCC1rHGDwuU=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB4960.namprd12.prod.outlook.com (2603:10b6:5:1bc::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.32; Mon, 15 Mar 2021 14:41:58 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::34e3:c46e:188c:ef53]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::34e3:c46e:188c:ef53%5]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 14:41:58 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: Enable lightSBR for SMU on passthrough
 and XGMI configuration
Thread-Topic: [PATCH 2/2] drm/amdgpu: Enable lightSBR for SMU on passthrough
 and XGMI configuration
Thread-Index: AQHXFdadNiTdsQZmokqr5aJXYtZW+6qFJucQ
Date: Mon, 15 Mar 2021 14:41:58 +0000
Message-ID: <DM6PR12MB407538A1FF04368DAFC2CD4FFC6C9@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20210310175530.9810-1-shaoyun.liu@amd.com>
In-Reply-To: <20210310175530.9810-1-shaoyun.liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-15T14:41:55Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=bf323c75-8fcc-492a-9d9c-91502d17d3e5;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: db57ebca-a85d-43d0-988f-08d8e7c07cae
x-ms-traffictypediagnostic: DM6PR12MB4960:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4960AE918B990D411E3CADE5FC6C9@DM6PR12MB4960.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ucInPHrVmjQySCkUJpwP6P9G59qZ8hs/DHq9kEZxlgyvu+SUQgroTUhdxShVNFD9RvLrX0ojLWVa4sMMbmaHYNoSTBgGm5Dse9Q1VTXIGMvGUUrTOm0i53U7zuIKS0fjwx6Xn4T5BRgoaQuZ2rOyAu2l23GPXnMhJKA8AguDd1A8HQIe7JvaAMxxq6zPY1ACg/4Hm4Md08mhyteoS+Wk3DFA9Cimef3hydNKgpLADg48iJuY/tsjxcclEkdUn/AP4QiolFEEEulyablL5Jt2cpZZQ25GB9lxzlubcjEc3UTbiPvEJ7JjSyWhdhy5FRoOTz3bHIRx+KzejEZ8KktY1NqdA1t9N5dpOyZAQh0xex1VtNU0glhkSQsJQkVNER6HKJpDXHijeFIjfNPlTCUfH671498oXlCblYFDTAZQZD/bGZA1hKz+1vfLoTHMQQdeTFjgs+rNaKdVe3MNARqkRvBJiKkxcb7nhj8lyAujXcBFeFSyzxdfqukYRY/CyqBIEQWj7uDOQSZ+wqs+QTuTflKbubOLC72jtvkseC/IyiS7V+gArilpd1CE0hIEVocDdXvM3Vxtwc5nrUfb8adcBlagsFHoI72t2kKeTocG0CM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(396003)(376002)(346002)(136003)(6506007)(5660300002)(55016002)(2906002)(76116006)(66946007)(52536014)(66476007)(64756008)(33656002)(66446008)(66556008)(45080400002)(4326008)(9686003)(966005)(8676002)(7696005)(186003)(71200400001)(110136005)(478600001)(8936002)(316002)(26005)(86362001)(83380400001)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?NeaqkIey0Hea+mFrkkJ9pc8bp7KQVXSE/AP5hfocuiq5r76Wq02BgNgwrGrG?=
 =?us-ascii?Q?eW7bAXlcUpowDP6IWxLFwO8gJ123JT4CvNTNQUvUa58J6fMfg3FzAtSN9uCS?=
 =?us-ascii?Q?UH+3c7GoOACrJnk9VU8D+2U1eJY52TuzZEHiyg7SgTHfjZxZlVpxSaNTUk+J?=
 =?us-ascii?Q?I/kc+txM1i/GDx3vgxIpR5foawKU18js6NR9sxRLYPNDYExrPyWRzddhWWe9?=
 =?us-ascii?Q?StAoPRSe0pH/jVdvfkJXGpmRO5filhQ+/qDVFac/ZFBHW/Lq70qGE+H9z8ws?=
 =?us-ascii?Q?xuwtZH4oA0e1Em+fDCTcHbXybZJifGUpASPGAYEhsD0cegY/Aj9fha4PVg0h?=
 =?us-ascii?Q?cGAS+C9P5x7TKVJ18D5VIb7hWyZQY40TVyUvS4z7XykuE6kbr+b2A+eXcqxb?=
 =?us-ascii?Q?tLX9yLCWfda7v1gxqu46RRz11MgUx5WKPM8dRluCQgUF+fIJcnW5F7HovWJC?=
 =?us-ascii?Q?JHmcRJV+zoWa6jI1f1KEpD6EU1HkiWlM3YLW7MMlExEWehpu0h+5LWkAwhnI?=
 =?us-ascii?Q?991khfjmfNPxYqkV9xEM8KxUodrbhiQpbSN/QYkNkt/sRQtkg/584dwtJeVi?=
 =?us-ascii?Q?3q/qtvpSIAyDEyIk2pLGcTgDL+nb7YKJxbczmpFMpfeGVYbKWBUUzepmj6Kq?=
 =?us-ascii?Q?mR6S/IqSaLyAZjp3UpDn83nyMHoQyi/XrXBV803jXKFZRKXGcpysKq0Xlhdk?=
 =?us-ascii?Q?FKBGIojeUCWSKM+DKgaxNFKzKSNAahYbYDji4bnJB+CC/JRmRW+y44r3qltU?=
 =?us-ascii?Q?TPbf858zGEsKeOC9JLEP2NfsMiU4wS2QJIAwgtgt83xAIqdSRnZcgNkpyrCo?=
 =?us-ascii?Q?OoJyUp+g9ivdKviyqk+0VqVcoOFrXziMedfWbM9TaMcTu4cF0RqYtviXW14d?=
 =?us-ascii?Q?grXEefZhQC0miE1R61bb2+qYbfvAA1ufsmUlbIviDP/EaV6O15Ervjkv/x0l?=
 =?us-ascii?Q?J5j/iwbOdXxjQlxEIHf6YeUKUTbUkMR3L9hH+R/AWoTUgjJY6C4OqRMRX81l?=
 =?us-ascii?Q?NF0LX3IkYLFQaGJFWoCPnu0uQISINJJy/he2KyBaCz2N0Dv4zuQlzYk6oUpy?=
 =?us-ascii?Q?mau1yfOOOkw1xN8uCi5L6P6yyTQ3BgUNnwLLfZ7bfkX2JfywfOv8HA4XwxjD?=
 =?us-ascii?Q?rU1gwe2U1YxNcMv8WPrvcgXlrhpG0WaNEPYNrYEUq/09OOEWkgqqdoHJf1mG?=
 =?us-ascii?Q?ir7mmusq7nMreMcxmFW6jm7+5bMZvkUtJcjZdM2F9wiZA/Yl4NKqNhoXM6s0?=
 =?us-ascii?Q?1J4SWG6Bjcnzgg6TQtS+rlN/qvAZPk33mbod2e0/A7k6iUeyqqyDxlVB8GNC?=
 =?us-ascii?Q?40wXYyDH/qU7N1RWD6cPfbYP?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db57ebca-a85d-43d0-988f-08d8e7c07cae
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2021 14:41:58.3075 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TzjWcm26YEtundJtRbT5GqHpWNETxfQS+48xhidODvkDU+K0USBtm/jCSR59vIc5osCYDls3znjveKq8wMg0rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4960
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
Cc: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of shaoyunl
Sent: Thursday, March 11, 2021 01:56
To: amd-gfx@lists.freedesktop.org
Cc: Liu, Shaoyun <Shaoyun.Liu@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Enable lightSBR for SMU on passthrough and XGMI configuration

SMU introduce the new interface to enable lightSBR mode, driver enable it on passthrough + XGMI configuration

Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
Change-Id: I59aef0559aba418b764e7cf716b0d98aca14fec5
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 4640cafae619..31a1783f211a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3630,6 +3630,10 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	if (amdgpu_device_cache_pci_state(adev->pdev))
 		pci_restore_state(pdev);
 
+	/* Enable lightSBR on SMU in passthrough + xgmi configuration */
+	if (amdgpu_passthrough(adev) && adev->gmc.xgmi.num_physical_nodes > 1)
+		smu_set_lightSBR(&adev->smu, true);
+
 	if (adev->gmc.xgmi.pending_reset)
 		queue_delayed_work(system_wq, &mgpu_info.delayed_reset_work,
 				   msecs_to_jiffies(AMDGPU_RESUME_MS));
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Chawking.zhang%40amd.com%7C04784f230da34296c57508d8e3edbae2%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637509957533562385%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=%2Bfx6ycEu2mX1unj7oi0bEvM0JMtMbFQ9u2J0UrxWQCI%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
