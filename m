Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EC3EC4453A
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jul 2026 17:49:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBD5510E0C9;
	Wed, 22 Jul 2026 17:49:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QnOj0f5Y";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012002.outbound.protection.outlook.com
 [40.93.195.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A9FC10E0C9
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jul 2026 17:49:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UZUWaVdnlTAbazI8PphD8RewQ4Ui6kLw6t7yAw9qj9Lbac2zj5kBAuspVuvODcyDHKrPwi3gyr38STREL5N7ncUGbM0NdcyfmndUYgj0IrprG7k4OnU5l7STejBm1FSh4LuetXNZqfF89oJfll5AbwaWUCcFIko5vfbgUGqXU6vkvpqfuBkjM842T5rYSNTBRMeOmQmKf5u2KheNsnBp6N4p4Y4sfWuOU1qeSPCQBIhSgrJZvfUC7sE7454o/QFF+hEHAPg+ahUxfQFd+pHVUOTm+TLT2Rhvk9S7FVUaoP25dN8kJWJLI2nzpx3oLZxTcuDdvomjt9adZG3kODWdEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f49UDeyhAnUCfKgQFHskhJnuERJrCiSEzBDUjU41g7I=;
 b=h1vp9SFMBLzSIvoXqkFcrPv75IJiBaPh4xm9TJgw60UJUIsf8KduCIaJfoHsPh6XrJ3xHjRPbStqmzoxL/FQOH+W1ZFWlvDXzsv53IloIoiCuNApy9A7LK1NKY7aW7Q5UOrNUluM/n9AjJVDoItA7AEwo2MyUDfBG8AsL7RWWtoStmwtOse0KV/q61qL8eia0SOFam6mSYYwpiQ1raIzrPex31HEBoWMvymIBbAzYrkcmMsfiSWgWEMRRMumNjfAHPx1CMY5RMvjdsbt2WroB/DPe/9lShyGVGovbDA3P7Ms0LyBqW7j4Ep2HPv4J6W1uy1i031Wf3XA+yAVcvfmkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f49UDeyhAnUCfKgQFHskhJnuERJrCiSEzBDUjU41g7I=;
 b=QnOj0f5YEM9M0e4N4G88/Dnbnl+ZldaaY0IpAx9qcu744MkUjuJT20c1/IeuzrINzGUvrDUGQRNQ4Hvknujy7kzL01lom+weK5Z0gkMVTHc/lLTHe0i2oasMpstr/vJ2KTx6psZa5W49auqxu2SFEM7KzV7RxEKYCfHI/W9clvc=
Received: from CH2PR12MB4055.namprd12.prod.outlook.com (2603:10b6:610:78::15)
 by DS5PPF5C5D42165.namprd12.prod.outlook.com (2603:10b6:f:fc00::64f)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 17:49:35 +0000
Received: from CH2PR12MB4055.namprd12.prod.outlook.com
 ([fe80::910c:508e:4578:4d3f]) by CH2PR12MB4055.namprd12.prod.outlook.com
 ([fe80::910c:508e:4578:4d3f%5]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 17:49:34 +0000
From: "Liu, Alysa" <Alysa.Liu@amd.com>
To: "Palacek, William" <William.Palacek@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>, "Russell,
 Kent" <Kent.Russell@amd.com>
Subject: RE: [PATCH] drm/amdkfd: fix uint32_t overflow in EOP ring buffer size
 alignment
Thread-Topic: [PATCH] drm/amdkfd: fix uint32_t overflow in EOP ring buffer
 size alignment
Thread-Index: AQHdGeQ7knkBEs2YRUOpnrTitoC5T7Z50RKA
Date: Wed, 22 Jul 2026 17:49:34 +0000
Message-ID: <CH2PR12MB4055834E1A31AC818FCD40D1E5C12@CH2PR12MB4055.namprd12.prod.outlook.com>
References: <20260722141218.1615450-1-William.Palacek@amd.com>
In-Reply-To: <20260722141218.1615450-1-William.Palacek@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-22T17:49:22.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4055:EE_|DS5PPF5C5D42165:EE_
x-ms-office365-filtering-correlation-id: 09b38e52-4616-41f1-43aa-08dee8199788
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|10067099003|11063799006|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: mOFeV93HCH1brqlAu0ew7ponouX2XXD19ISpzqDnmc64/RsF2LYobvyr5Q2YzPBqWN3NOTy2ochOFnN5FEhkd5Q3HejaHsZozAssyx0hH+04ia3+fwlUAopcU2GgH5eQ3oj0D+zhZWNUESZVFbubgQ41oWRg8ip4PUOvFlhmvdeC88VdPXjwCacGHZdP09lHNbh3wWmw5JDH3kTA9fblIWiavN7X6LUUBTmtnQqakKYwEJod/S5TTQ9nCz2JSwTeYITzv40knMl4ml+2Ir1X02pxDdwuFbg4MgC4GMSC80tci5R3HjgvTu1T0Tlm/8r6lEIMKbRJTJ8tmOdNtuvnrven5jguWL1slFkVVWEVXYCggcbxikSuUnYJeocck5IP1EASsymsz3sBJei3FH8EPoFbPIdjCVaY+aZ6ZtXwprATeQTQZv2wAomPMtqe+sFVDDsT8C/sbjHrmIryYB0WLbIcJ6BKM8E0tgNN9OgiF85Fyv7H+CI9em3j7EXhqaoDWd93XpOVtf2/SFY9cSLC5rdy72dl8Yt4n4DA9woEoB6TUXwVB2esUo1VjLf5iIvEZiJjYz2LQ7hhqeagpC5aT7MX270MlMTJ4rPFAIWBLUGzY0EnAyD2BEhhnMw41bG45NZncttEZ6jo2yU58/8xJE+WOMAJ1p1H4hn8oo7GrGPdWT2QzSCdlXMvJ8ht1Bm2y7IXV62D/ScYOLiO11tdLSq6Yof3zsT83y+6wv2MTgA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4055.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?s0MAjFVOx8Hdm6Xit+yGCUq6vornS+DDlxEtpM8KF1Ee+eeI+t1Kw1oxh3qM?=
 =?us-ascii?Q?D/xyQRp0bmwpfA9a1WjnCeZr8RXhEsR5vEcQGHza0iNjZ6GXaoKU8Z4mrm3Q?=
 =?us-ascii?Q?s6k8hBtYlbGFzGJNClkA6W9NssPzkI1n6KyCvs5Nlz4RiZ3umSCvF9KgEjme?=
 =?us-ascii?Q?KvygjOsSOrBgj8Us5iUhpsYMRU1dRsboyhcCBOXPqyU0tjgi0g6oSs7tTAXG?=
 =?us-ascii?Q?vg5JMZdW9hFXK7A4fR7oKHkUcnpLyaDC/g2dCqLD8R/EWp7g01WA6lbwwze2?=
 =?us-ascii?Q?alMXX+q2e2zf5AWGyzWxWIYvKn3yFp68MemcwXVJHREohE+KVIQN/0a0f4GW?=
 =?us-ascii?Q?fHvohhBQhQZpRIpMwhgn8+3/EeY4yTlMYCCpnhkUm7bMGnM6qmJ0MIiOOOme?=
 =?us-ascii?Q?anDeeMhhc5SEjvrRbEo3Dtpxk1fBSvgW1tWk7D6Vg+LozlG7uhQkFVrB01j2?=
 =?us-ascii?Q?a4NbNwuPVQBFhE4rqk9/7aPLH4jpsqRQvQbx4+3No5nYBdwpmhYYqQ8PPbdZ?=
 =?us-ascii?Q?7ojaGmNly0Z/Kvr6o+8brrv1pvMg+YST26Pd5z7dmReBAuG28CKiy41oIJ0P?=
 =?us-ascii?Q?buH1WxMJlvp6WEzbnbSz7WovsWwKINd2tJKnAD4tO/Asa6OOKyQiJBFzUe8/?=
 =?us-ascii?Q?qpF4QM19eMXY9LY1/8Wy6iYoay3SyNm2OFoLs4evniTjIZbcvRN2BJMCxoJD?=
 =?us-ascii?Q?mUhwdSVfpx4/p6p1rTQt4i4Br+SeDrHNWqeXBh342wDCb1eDGfPlOI9+YE3a?=
 =?us-ascii?Q?r951lz8dzWMnF2z/FAycUQZFoQXkf4maK2qxa+C+H9+lzkwUmWhFYh4O0xkt?=
 =?us-ascii?Q?m3oEa4Js3J05L08Zu5JC13zb/TlKz33KCN+NJ008TwP034cg2ouEo82Sg530?=
 =?us-ascii?Q?tkjQ7C/8WGn9/NqYOacwb1PV0x+eBW5aRLkl3dhIkGTZHzHo4bhRJdjRsn56?=
 =?us-ascii?Q?Ykvj1cHzyoKd0tmFuJUherU0cmRc4q9k5yIBPd8cKEBPwPYWYCeQFKWSwD+Y?=
 =?us-ascii?Q?OYqREryujfef6Tvrff7Xih5ijcJ0d7MpsXaFHnsxmGf7xM29cquq1LSs0RgL?=
 =?us-ascii?Q?7BFWSLd9rEryTMJ/NeD38Y8wJ7u+bxlshqRObeTRGLBlzPh/+pl94FZFUU/4?=
 =?us-ascii?Q?oKtkSiZDddNijbAWeo8uTFs2a4K4MqQb5pEYHwglL9pLpWEX7Gljp0c4+TgP?=
 =?us-ascii?Q?qPgA73P83cPFtWuIzM1Jf5Bv595WJ24FeF2CMHuZIlzqmHYMJ9nyoiwaIb3w?=
 =?us-ascii?Q?Dkfm69z52QHNuShaVXM61CsGFNLIGoEY3XDHxPPQN+fBeu/81sXw9cfWKkgS?=
 =?us-ascii?Q?wfOa9CRX3T1cQQBNpXBzZ2LBPOxrUKyn9jlUJPaufA1bQfHRiyxBm5RG1IpN?=
 =?us-ascii?Q?U5QFTB3g9KHmjFtahXcO1p4JOcida0BzXbjYtoJPHR94BrdzaSs6c4W+HFO2?=
 =?us-ascii?Q?dCQSTN+Y8I9gH/J+l8PPcVamleqhzIRyeS7VZv55OtJHy13E5TdiQRRWJpW2?=
 =?us-ascii?Q?76VhhnsqLm3F4diYYQFO8J223Ym28ydMVo/NaMt3QW2JW11Fut22gWzwfqUa?=
 =?us-ascii?Q?kJbpq23EkRqVP9RsDa9XZJUCq8ug6D7STKf+Pd6GSKKJYVGC+zVltD7uad2K?=
 =?us-ascii?Q?oe7qNBv8vIfwpZkxUH3T9nmMrFtE7yOxgKaawTaHptV527N2qbctg/kDfUmW?=
 =?us-ascii?Q?4+YTLLV6URSuJYJAlLgE2lIttHgd67dUYNoLNDDdEOh/rsMh?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4055.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09b38e52-4616-41f1-43aa-08dee8199788
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2026 17:49:34.6403 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: URXP4x6YHJzz9UoyUqVuwCOnHwGpNGCSJP53gfATvSjBt+wvKUofEK99QVPLYUm6q5AaRu0ZH/7Ea9KVv1DxXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF5C5D42165
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

AMD General

Reviewed-by: Alysa Liu <Alysa.Liu@amd.com>

-----Original Message-----
From: Palacek, William <William.Palacek@amd.com>
Sent: Wednesday, July 22, 2026 10:12 AM
To: amd-gfx@lists.freedesktop.org
Cc: Palacek, William <William.Palacek@amd.com>; Kasiviswanathan, Harish <Ha=
rish.Kasiviswanathan@amd.com>; Liu, Alysa <Alysa.Liu@amd.com>; Russell, Ken=
t <Kent.Russell@amd.com>
Subject: [PATCH] drm/amdkfd: fix uint32_t overflow in EOP ring buffer size =
alignment

eop_ring_buffer_size in struct queue_properties is a u32. In
kfd_queue_acquire_buffers() the expected EOP buffer size is computed as ALI=
GN(eop_ring_buffer_size, PAGE_SIZE); ALIGN uses typeof(x), so the addition =
is done in 32-bit. A user-supplied size of 0xFFFFF001 wraps to 0, causing k=
fd_queue_buffer_get() to skip its exact-size check (gated on size !=3D 0) a=
nd accept any BO mapped at the address. On GFX8/GFX9 the MQD cp_hqd_eop_con=
trol is then programmed for an 8KB EOP ring backed by a 4KB BO, so CP EOP w=
rites can land past the buffer and fault the GPU.

Cast the operand to u64 so the alignment is computed in 64-bit; the size ch=
eck in kfd_queue_buffer_get() then rejects the oversized request.

Fixes: 42ea9cf2f16b ("drm/amdkfd: Relax size checking during queue buffer g=
et")
Signed-off-by: William Palacek <William.Palacek@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/a=
mdkfd/kfd_queue.c
index 98a5512b701b..b249e7d1af48 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
@@ -288,7 +288,7 @@ int kfd_queue_acquire_buffers(struct kfd_process_device=
 *pdd, struct queue_prope
                }
                err =3D kfd_queue_buffer_get(vm, (void *)properties->eop_ri=
ng_buffer_address,
                                           &properties->eop_buf_bo,
-                                          ALIGN(properties->eop_ring_buffe=
r_size, PAGE_SIZE));
+                                          ALIGN((u64)properties->eop_ring_=
buffer_size, PAGE_SIZE));
                if (err)
                        goto out_err_unreserve;
        }
--
2.34.1

