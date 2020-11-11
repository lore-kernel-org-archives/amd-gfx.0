Return-Path: <SRS0=tzQw=ER=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC4AC388F7
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2020 02:49:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E2AC2168B
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2020 02:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="e2+Uu9xb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E2AC2168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3B3E89803;
	Wed, 11 Nov 2020 02:49:46 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BFA989803
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2020 02:49:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HwmTEzMRNig0dNBAMYqMit8kHug82a1B3JDgdRFiyVs+Kpr8pvQUrKfgtZUbBxj8poYFl6K6sxtyS5Ist2L3QOXzIQaI8vXmcVKleTvm5kSEBR9eIiSapKpW+wa1xQZvGnmBlyTn63kdFvlwFlDmW/h3UYBCEAWGZlp2Nys5E7WuEkkxiqRnpgeES5LdJ8Icy7681znB4ehuQUnORIu9a0yVkd62X7CXQ+6MQ2k/rwp/8YYsSyxaytE8B9LNF6M1WdIY+WX/iMFM8HDF0P5Rba06XStHcq+GAl6XVKVLtH9VcavMFtuvGSqTeF61ALloVJOH8PeuBNCG6okLmTrQhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Myo33pxlwvEeavhxrXaHf294KjevmlUFQu8yc3ePImM=;
 b=QDfS7y/q4ioe8nmubUOd8tRQe5bds93CaGc+hCEvrZVR26mBaXazg8IKBzE2tF7ps0yWHx3aKMa4nRx2TNIMfHDeh8DnuQoCPOtCAXOEdbA/jvQupAN0CFk10uK7n4e9LbV5pDGuPn1I3IRa45z3/dj8aaS03opHvC9ifFmZDbRjJBAc5CGu7ewOO5N9EzHauBwDplN2o0XMoJtfMXBE7MSFqU5PNxpRaiH3TaGk9Q2IVlXfc8ys3ukEOOIQavtGCTmZp5WkqXWJnQ6ymnPddhIXB0+ea8tDeuxGh2p3SUzeogwPwjf1KufHT03jcUh+AgfO5Wcu0HRolPKesgzIIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Myo33pxlwvEeavhxrXaHf294KjevmlUFQu8yc3ePImM=;
 b=e2+Uu9xbtNbn8KJnwSMy5LpFHHVPuQAGN0m13SMtNufCwtHA4zBCq48yTNDdvT/tK74LDtYeYUwI2k3YL3OKk5kTiUhcy87hhjqGTKztaqvhldJI4U/PUJR8pQzLUgxI9YsVaAkZw+OKvgnwvKcYOIJUROlY2no0kOUfCPnqqw0=
Received: from DM5PR12MB1708.namprd12.prod.outlook.com (2603:10b6:3:10e::22)
 by DM6PR12MB4941.namprd12.prod.outlook.com (2603:10b6:5:1b8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Wed, 11 Nov
 2020 02:49:37 +0000
Received: from DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::61a5:a549:4cac:37e3]) by DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::61a5:a549:4cac:37e3%7]) with mapi id 15.20.3541.025; Wed, 11 Nov 2020
 02:49:37 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Zhang, Bokun" <Bokun.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE:R [PATCH] drm/amd/amdgpu: Update VCN initizalization behvaior
Thread-Topic: R [PATCH] drm/amd/amdgpu: Update VCN initizalization behvaior
Thread-Index: Ada31UDJVr9t95u1Q/q42juVjtthLA==
Date: Wed, 11 Nov 2020 02:49:37 +0000
Message-ID: <DM5PR12MB170878F2AE7166EA729AA12084E80@DM5PR12MB1708.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=8a11647d-1053-4b39-8d74-0000c4fce06e;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-11-11T02:49:16Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 02815078-eac8-4695-2a3b-08d885ec6dd8
x-ms-traffictypediagnostic: DM6PR12MB4941:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB49417CB2DE9E7CBE9BF3BBBB84E80@DM6PR12MB4941.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qQQ34Rc719H8XTAmaMFEApgZQlB1tGe76Ep4stqTwD6rGiVYD7qxDfSHHemblBb9Akl+1qpSu1oWvhUFK1N5RClZqAue7GBVuLWqke3mtsQ7SUXAcieR21QsJVeXqH/jEqMNfj+U7G8XRm12VrnHjLgizhAYxKfDGZ6/hBxzCmGU7JFu2l13Ftk06+YGgPzXjQj2X7md0ZOfbm+aj7pVYcUyEo6Lia4rngYRTeYGJY3ma8OH2+PxJIi9NChvO5TzgtpYuHZifMHCKaib+UMwTw6xdKT+XSqDqLWyQNACH5aytWA59/Gc9SLTXVD55jKaBCbsYsDb0ih8/2VVyA9NnvIs67tclPyZ2qfczc0PSBE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1708.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(346002)(396003)(136003)(366004)(4326008)(2906002)(316002)(86362001)(478600001)(83380400001)(5660300002)(66476007)(966005)(33656002)(66946007)(64756008)(66446008)(76116006)(15650500001)(66556008)(8676002)(7696005)(6506007)(53546011)(71200400001)(45080400002)(52536014)(8936002)(110136005)(55016002)(186003)(9686003)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 5AK9/S/rfkSeLvl1IWB7Uhfmf3nNB6DXi1RaG+A30Wh4bWBV/C7fAgOWMiAeBqO9JMstfNWFBzmdAfOYr4Wb6b1sikeFadBEFrQTCfAV6jrTbqRbfuU6Xp+KoKm+QPZIHt+z6tALhwvew6SvxrhXhIEwHbkXm5i3H+CBJOarg59m7py+b+BXHQZMuYo7LB5F642LGFLTGZOVjKQW8eOY6vJoVdmVaL4EIDJKimSEUdTw5g8l13+dyK7t9Bt/fEPmpH/IxfPWJNYvRIpes/ib//NQBqgexsiFjX+/hccV1wg35Kd5jfuTuPKlo3hq8JcYe0D/MmHSnAp+q6bGHuJ4MaMr9al9nW9L+KzvWbNA+3kY0BP6NIcTAblMkw7iT8LipNAkJq52EfHB5OE/RFreePRQ6pHPwMpX+su4B6IRatGksYEugTMpAq9tprBhXjnQ9WUGiB2UHFyT7HopepO/SvO2ECeCsoc7aqymXBQ9BdLGH2tfF6gZ+JSNCrSi/miDGzTtnjWlM/7hjnDfpX7A5oFi+QUjen6uY2gYR4jBQxWnRQUXlQ+n/m3nDx7l+KPSubcIIbuUqClVFhfFPvtDJP6kbcpjqDY7wpWdUQF6AGgc6Yq9g0S48lkD8tAboWSYEKucqxHdr6BPgMSVfFLtnyZFUF6eREStVbCD7X9W01hETCU28guWqV3qyrOBYDD3Ci+rQUAYvM4Ek1QYOcEeqiE9EwZfZC848D5c7TMDMuQCJGAx+u/dLpOYPRb8oXGG6xs0Ana2vbfTbG2w7O+qQNlRfaQ01n/XzWYZqIz0xXUGMsZCHZ03WKiLju2bwYOt0oaJ5IfXLez2bt4pk9p6N3Kq7zZzn+gJxVtmOr/abL8TwEYj3GQ9bOdSWHd1MXrKisnlHJSv8LxIeLtEk7739A==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1708.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02815078-eac8-4695-2a3b-08d885ec6dd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2020 02:49:37.3744 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2ePr0VtsdayKAMid9AbSitFblkO8+v9nQxgtkj05rY2stMnuPL+BxE3U9fGt7iek
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4941
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
Cc: "Zhang, Bokun" <Bokun.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Monk Liu <monk.liu@amd.com>

_____________________________________
Monk Liu|GPU Virtualization Team |AMD


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Bokun Zhang
Sent: Wednesday, November 11, 2020 4:17 AM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Bokun <Bokun.Zhang@amd.com>
Subject: [PATCH] drm/amd/amdgpu: Update VCN initizalization behvaior

- Issue:
  In the original vcn3.0 code, it assumes that the VCN's
  init_status is always 1, even after the MMSCH
  updates the header.

  This is incorrect since by default, it should be set to 0,
  and MMSCH will update it to 1 if VCN is ready.

- Fix:
  We need to read back the table header after send it to MMSCH.
  After that, if a VCN instance is not ready (host disabled it),
  we needs to disable the ring buffer as well.

Change-Id: I2c5dc4344c5919044370dfe606bf5980a202c662

Signed-off-by: Bokun Zhang <Bokun.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 46 +++++++++++++++++++++------
 1 file changed, 37 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 3970a0ccb6a5..c5e0a531caba 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -294,17 +294,19 @@ static int vcn_v3_0_hw_init(void *handle)
 continue;

 ring = &adev->vcn.inst[i].ring_dec;
-ring->wptr = 0;
-ring->wptr_old = 0;
-vcn_v3_0_dec_ring_set_wptr(ring);
-ring->sched.ready = true;
+if (ring->sched.ready) {
+ring->wptr = 0;
+ring->wptr_old = 0;
+vcn_v3_0_dec_ring_set_wptr(ring);
+}

 for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
 ring = &adev->vcn.inst[i].ring_enc[j];
-ring->wptr = 0;
-ring->wptr_old = 0;
-vcn_v3_0_enc_ring_set_wptr(ring);
-ring->sched.ready = true;
+if (ring->sched.ready) {
+ring->wptr = 0;
+ring->wptr_old = 0;
+vcn_v3_0_enc_ring_set_wptr(ring);
+}
 }
 }
 } else {
@@ -1230,6 +1232,8 @@ static int vcn_v3_0_start_sriov(struct amdgpu_device *adev)
 uint32_t table_size;
 uint32_t size, size_dw;

+bool is_vcn_ready;
+
 struct mmsch_v3_0_cmd_direct_write
 direct_wt = { {0} };
 struct mmsch_v3_0_cmd_direct_read_modify_write
@@ -1367,7 +1371,7 @@ static int vcn_v3_0_start_sriov(struct amdgpu_device *adev)
 MMSCH_V3_0_INSERT_END();

 /* refine header */
-header.inst[i].init_status = 1;
+header.inst[i].init_status = 0;
 header.inst[i].table_offset = header.total_size;
 header.inst[i].table_size = table_size;
 header.total_size += table_size;
@@ -1425,6 +1429,30 @@ static int vcn_v3_0_start_sriov(struct amdgpu_device *adev)
 }
 }

+/* 6, check each VCN's init_status
+ * if it remains as 0, then this VCN is not assigned to current VF
+ * do not start ring for this VCN
+ */
+size = sizeof(struct mmsch_v3_0_init_header);
+table_loc = (uint32_t *)table->cpu_addr;
+memcpy(&header, (void *)table_loc, size);
+
+for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
+if (adev->vcn.harvest_config & (1 << i))
+continue;
+
+is_vcn_ready = (header.inst[i].init_status == 1);
+if (!is_vcn_ready)
+DRM_INFO("VCN(%d) engine is disabled by hypervisor\n", i);
+
+ring = &adev->vcn.inst[i].ring_dec;
+ring->sched.ready = is_vcn_ready;
+for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
+ring = &adev->vcn.inst[i].ring_enc[j];
+ring->sched.ready = is_vcn_ready;
+}
+}
+
 return 0;
 }

--
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cmonk.liu%40amd.com%7Ccb49c2c170054afa706808d885b5aabb%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637406362602342785%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=gyfneg3amwv16LJD6tjP6hoo%2F615ODNCOsOU%2BJ6JbuQ%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
