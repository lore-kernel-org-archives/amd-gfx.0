Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1278CC2D0CD
	for <amd-gfx@archiver.kernel.org>; Thu, 15 May 2025 17:25:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1E8410E92A;
	Thu, 15 May 2025 17:25:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3CwnKUHB";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D95A710E92A
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 May 2025 17:25:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gxybWBqkp30qOlzNqdNdOYNnNMY4iV3yF+o6FWEJgMohtwONVtnMm9Tbm/WOwAXIjWns2UJWmHEaF/UHAk+VaxLDnOpPGKvwIPBRE7zAWWP+rkqAijOaJwbE415z6zzK5fkZXAvsW1x67yrvGWYwwVRRg/BbQwbQqJ+Z8JZADTFSapTnkfIVLL/tExoN6sWz0phiBBqPldnJ4+FhmbosL7rTIy5imAab5QaHT+fTACNOihqGVt9bV2aa+7decPa0C/0FQygiaIJCuRTq0GgtbXtfJh9hsSlxEyyBSCmHjmDmBLOXb5ARUZqQuDslSTKabdl7Izhk16WH6Uj2sghRHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RLOU0+9aa4G4RMqaH8wSlu7+HoEm9tzct7fhyYFnK7g=;
 b=GzFHjLeBkUiFYfmV9JzyIis+wS11N6bldlJbGToVtFjPMvid9laUu68PG9Lul3Lz+jb1ks+3t4JLTCWyb1KBnIszhW6mR/yFxlB5jxwlEMdK0EtlKw7fVweAo+UGWqcxEOU3YgzKzYguFUTjITaU1n3IDK0SpFmS8/jwJggYEz8zz8x6aTWukpW+5LdhWvj17n1duJP7rZKckye9QjFVWlIOa7JvLi7GEfdxG7GQlQdK6eEJp8Pzg630kKhiwHV/yc59DBnk99NtG7S8+XlITVLw2MBLl2sVHEL6G0FUbvAkcMr+lrw7KqrT9ZVLVi9x4YYsvYVot+Kb4igjKMT3UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RLOU0+9aa4G4RMqaH8wSlu7+HoEm9tzct7fhyYFnK7g=;
 b=3CwnKUHBCRKTHLA/FqieOG/pi8dsuaqszWOig0spJs239cNuV9meB4dcEDbCsbkPaPR2YOu4/xNA4KJ7sh/uREjrbKauBK9vwbRejHka82ci/pklhdNCJYACrUeegJtvhLitVB9grweRRY5sRRQ3oEkyGktzBhBaZ/e2OC8X3SI=
Received: from SJ1PR12MB6194.namprd12.prod.outlook.com (2603:10b6:a03:458::12)
 by SJ2PR12MB7989.namprd12.prod.outlook.com (2603:10b6:a03:4c3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Thu, 15 May
 2025 17:25:42 +0000
Received: from SJ1PR12MB6194.namprd12.prod.outlook.com
 ([fe80::df0b:3ee0:7884:c6a9]) by SJ1PR12MB6194.namprd12.prod.outlook.com
 ([fe80::df0b:3ee0:7884:c6a9%6]) with mapi id 15.20.8722.027; Thu, 15 May 2025
 17:25:41 +0000
From: "Dong, Ruijing" <Ruijing.Dong@amd.com>
To: "Wu, David" <David.Wu3@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Liu, Leo"
 <Leo.Liu@amd.com>, "Jiang, Sonny" <Sonny.Jiang@amd.com>
Subject: RE: [PATCH v2 5/9] drm/amdgpu: read back register after written
Thread-Topic: [PATCH v2 5/9] drm/amdgpu: read back register after written
Thread-Index: AQHbxbgw2jXKOZN71UeqQmjN+FI4vrPT8SQg
Date: Thu, 15 May 2025 17:25:41 +0000
Message-ID: <SJ1PR12MB61945DCC12B15B2F29F079079590A@SJ1PR12MB6194.namprd12.prod.outlook.com>
References: <20250515164102.808954-1-David.Wu3@amd.com>
 <20250515164102.808954-5-David.Wu3@amd.com>
In-Reply-To: <20250515164102.808954-5-David.Wu3@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=98541cb6-6700-4ecf-8c1c-1fe6bee61d5b;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-05-15T17:25:02Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR12MB6194:EE_|SJ2PR12MB7989:EE_
x-ms-office365-filtering-correlation-id: cdc32cd4-615b-4711-b985-08dd93d5848d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?y7rmrARf+s8J7tx3Y+44GWOImSAoiKaLIPDUIUlyCJvVZcicI0pDGQ/zFJpe?=
 =?us-ascii?Q?RW02B65rjNiSGbgkW9WUcqo8QHiZwq+kOXFWiPeL6PEPuFPoBljKSwrB8hi+?=
 =?us-ascii?Q?BetOV0zUXdL48zUwtAZdfqNvSaT84MIxvOEjhQzcesUb8bREflctkgvrgE/5?=
 =?us-ascii?Q?lMhLp2WYwCO6z0JWjqBksxnxUNAQaAaXdBQ3mZKOQ5ymggys9Wuyz1J3SXXu?=
 =?us-ascii?Q?YdeAH22oZQHbc24ns/tfdh4TMhSdBETwPNRlo4GLEgQiwLK6EEIKwyAeGagV?=
 =?us-ascii?Q?KkJotu+bV6lh/fD+COYJRQQReeYIhXChfLKMAuPlKc00zanUPqJoWsN3Hnl3?=
 =?us-ascii?Q?oXc5qYsiwbkv9b3pB2zpooaiUEhdlrDMHVKyzZvmWz4gBsaBoUCurY6Kc4Fd?=
 =?us-ascii?Q?7rKwQpZxCmM3QsNd4eupBnIbQxbfkFd/jfShOQ+jS6+mLG+EuYPmPz/iN+zK?=
 =?us-ascii?Q?ABvfkJwJGk4n7glfXcYLLWJg0FVO36qTXg2onPMOCFuyoSLvb/tVI3+7UskX?=
 =?us-ascii?Q?iy7C/W4QUEBBQcY56BMcIrXDtkWS5stf/WJvX2lXXl5zTnH6PcDLqBIgSKmu?=
 =?us-ascii?Q?j1pQiwJLjOoQjq+1CxcAFiqGA+YdEktv8YHAQsy5ANGGLf/Y/hSjd0MnPkPC?=
 =?us-ascii?Q?n+xlTH6W6bQgJFZFzTcQvg7lplwRdhKFSu9hzeDXkb3legrk/oeZ29/H/Ex4?=
 =?us-ascii?Q?X49XCU21t69f/8KHLsdWdA5DhVUalDogkuhD/v9RQ7BNnf3Lzxfw3rvIC1ld?=
 =?us-ascii?Q?AHZe+XER9eZw8WfEAbpt6JEzii96h2xh6TzIgJRo29YMCiALtYZw2aMq+rI/?=
 =?us-ascii?Q?0W2EqyHPwgQvOme0mnmDDzXNAomCd6AtlQm+H2QZH+7iEBNRLmqZElf4Y+Fa?=
 =?us-ascii?Q?ZhkVHx3SWf4vfivXsf+diZeu+P5s3euM1eEv62ElsjYP05f3+sgkNJi+a3rq?=
 =?us-ascii?Q?65EfqpcA9XfSXkkbGKLOkQ4aWj4aWgRPt+tei6ifW6gOw7oCSr5kOam0xIj3?=
 =?us-ascii?Q?tU6TqKwqqdQTrTKRXDQa2sGWkNSIxCeSDwfCwEJ6eMCvTCv9kAg6wCMqPX8M?=
 =?us-ascii?Q?+5Hejou1AxdFdvKNzPQ7XNVGkPWO3NLT225xiyXR7I/RRIJdPKZlYivSaO9X?=
 =?us-ascii?Q?ikUND0/34HygheUH/ODLTZByFp5FrI+yFjb9FxxCgRxmt3vBJOMDW285MnB1?=
 =?us-ascii?Q?Ce6CSo4qRb0rENWTLQWzJqe/ktO1Y/tDJkWFE+Bzi5m1lK7Gy/5+I2kxiXCu?=
 =?us-ascii?Q?sd9+NbSTx9n0qzVLPfUldNo5b/sWN8BZSYZrhMPfAxil2M2yuGf42W2lDicG?=
 =?us-ascii?Q?X2Vuj35Luc+wMbDb/6OFjv3VMty/lJR1yf1SSpWWiALspwaFoD3I6oOouGi3?=
 =?us-ascii?Q?O5gc2m/W9YmJu5M1/tyq9wCUsOkfjN8xAAZWt4ZkOBpNh+yNEBrNaRp5TJTT?=
 =?us-ascii?Q?7lrC8dTJEjNEy3eCEnYNKmDkl6GYQqFNkY8flBw3658xcouJxWOS2g=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ1PR12MB6194.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2ExNUbwJFBwFrcTcEnI3s7ey5gsdIp/99h9vwQg4naCZi7OF3Ky91x7CcgW2?=
 =?us-ascii?Q?BgtX39NxQQ5N5Rcfcvyi8meB3x8JdqFzR6WvtlvM4BiEfXMxg0FVZ23NgXwT?=
 =?us-ascii?Q?VbBCBi6t5QwrMlm96TXfflazpriENw8Oegu+j+K0B65H5Mu9m9JExG2kOrz1?=
 =?us-ascii?Q?qhN4RhAXB4sawUs57vC76Gthe9TGi9yEh2NjxiXZyPs3I1tOhzieLET3C6Fe?=
 =?us-ascii?Q?JJoNnqYNWhCNEXNuVefs1vVg6G59msE3Hsxdkj4tWrrc2Qmqd/rPVsoaJp7j?=
 =?us-ascii?Q?NNjWPPk3gASKat03MmZOb9Y7BuBZM//W9gEA1BHj16arDUZQODK1bmUi6ssZ?=
 =?us-ascii?Q?mOWEKjVfRwcKxo0xYFoccgQTWTDzmLEVnyZDRLt3rg7YliNyNI2MwtJou6Gh?=
 =?us-ascii?Q?ZxZNviS4//YkvupKLFImnPuRhGL7hdkWIgJPTqSujFqDpF2We2sshiZ0CD02?=
 =?us-ascii?Q?M9uxgwDUuu5QknTA/6900uAoAlbtnp+aBkM9xKgPvx+E3ch/A+vIJjUZiX7s?=
 =?us-ascii?Q?CBdQPatJE46hbvBjXh+DDSPVrCj1AMdWwQRP3Dh2/oKINKeP88VSwls0R+vW?=
 =?us-ascii?Q?/ZkFHJ4AcmRM3Lw4J4Y8STi2vc4ZhDTn+z4xuHBlJlCiWqzXl0VD6RWR56Zw?=
 =?us-ascii?Q?IZS73LcVPIojdKRjZnpnuG33irplwnzyNtLyuLSPGMMsX/WlQk3zjsylBwp6?=
 =?us-ascii?Q?fxZ6qJ1El4ReFxnixkqkcNRv7G7XuFHtigjwGtZI7kA2p9c0JUIXVCt0+Sr+?=
 =?us-ascii?Q?lZZwNTFA4KnjrXbbRF+i5tZTcOp51pyz5qlMbCLRwFena8YvnWp1eHpZuf+m?=
 =?us-ascii?Q?FUM1X/FnrT24JF6ACg09yS2+6gYZwDY5u4t8CL8JrnNJW2bVywLuuKwx7rTg?=
 =?us-ascii?Q?VuTEbL1VW5RqxXTx5zCTr65AXeJhUZ21gZnSenMsbFr5rjuzgh2Ecm9dKpGQ?=
 =?us-ascii?Q?oDiRA2x9pY3GTxJS4m1d1XSO81M+iSlcZzD26lc8oB5lM+e7Y3aikuyPlU2Q?=
 =?us-ascii?Q?Od94AbjcNKv4uHU1gsqhlVA5Ayd1LNcy/R3OlGNg0LGbtB3UIzFpR0YCelsM?=
 =?us-ascii?Q?VVDT6p6/SDoFrzueosBme80FcffVtHYoD7eWTilzf88AgvqDa98SLT45fTpb?=
 =?us-ascii?Q?qg1kFQbBrKdGAOR+1SKh7X/luxSTPu4A5zNIidOhflBaXPDYje5DwrWKVXVC?=
 =?us-ascii?Q?L+mA+e7E1lETSOz34OfxJG+hPb0MP6VcsDY+6GOA2t5o1eA9PwpBqsESI3sc?=
 =?us-ascii?Q?t0RC7W2gjSf8grz1m3otUne7w4duzwgCsjiA0QntPZJIzUoPvr5+i0QKm/2T?=
 =?us-ascii?Q?qI+iqIGndSvE3O9j6jVIm7Byoed9VwSkKXbtICTJZ4ZYj8atFr5PWIwuhS45?=
 =?us-ascii?Q?NOcwQXJ1JPIdubE3iVndMaLxbkjmUubGhNbF7GB9helEdqwEPvqcZymZhyX0?=
 =?us-ascii?Q?sqBAmjpsPBIB4WB8KHVQJ1cDkeS5YEuTDck/Z5gCgLg2BtjjLHbE6Lrz+1S5?=
 =?us-ascii?Q?rOyV5BRLNF0tx/3rbzaWyCNlCr5cftvOdUoFCrhP6zu0CMu0qWScNup3xDgz?=
 =?us-ascii?Q?C4QSJP81ZFINJcdrpB0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdc32cd4-615b-4711-b985-08dd93d5848d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2025 17:25:41.7298 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8A6x5UHR93FboN6bLZG3+w3hPO1FrSIGGbV0+irP+rRVyW8Cx9pIjgzX1O5e1es8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7989
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

-----Original Message-----
From: Wu, David <David.Wu3@amd.com>
Sent: Thursday, May 15, 2025 12:41 PM
To: amd-gfx@lists.freedesktop.org; Koenig, Christian <Christian.Koenig@amd.=
com>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liu, Leo <Leo.Liu@amd.c=
om>; Jiang, Sonny <Sonny.Jiang@amd.com>; Dong, Ruijing <Ruijing.Dong@amd.co=
m>
Subject: [PATCH v2 5/9] drm/amdgpu: read back register after written

The addition of register read-back in VCN v4.0.0 is intended to prevent pot=
ential race conditions.

Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/am=
dgpu/vcn_v4_0.c
index 8fff470bce87..5acdf8fd5a62 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1122,6 +1122,11 @@ static int vcn_v4_0_start_dpg_mode(struct amdgpu_vcn=
_inst *vinst, bool indirect)
                        ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SH=
IFT |
                        VCN_RB1_DB_CTRL__EN_MASK);

+       /* Keeping one read-back to ensure all register writes are done,
+        * otherwise it may introduce race conditions.
+        */
+       RREG32_SOC15(VCN, inst_idx, regUVD_RB_WPTR);
+



Use the same register regUVD_STATUS?


        return 0;
 }

@@ -1303,6 +1308,11 @@ static int vcn_v4_0_start(struct amdgpu_vcn_inst *vi=
nst)
        WREG32_SOC15(VCN, i, regVCN_RB_ENABLE, tmp);
        fw_shared->sq.queue_mode &=3D ~(FW_QUEUE_RING_RESET | FW_QUEUE_DPG_=
HOLD_OFF);

+       /* Keeping one read-back to ensure all register writes are done,
+        * otherwise it may introduce race conditions.
+        */
+       RREG32_SOC15(VCN, i, regUVD_RB_WPTR);
+
        return 0;
 }

@@ -1583,6 +1593,11 @@ static void vcn_v4_0_stop_dpg_mode(struct amdgpu_vcn=
_inst *vinst)
        /* disable dynamic power gating mode */
        WREG32_P(SOC15_REG_OFFSET(VCN, inst_idx, regUVD_POWER_STATUS), 0,
                ~UVD_POWER_STATUS__UVD_PG_MODE_MASK);
+
+       /* Keeping one read-back to ensure all register writes are done,
+        * otherwise it may introduce race conditions.
+        */
+       RREG32_SOC15(VCN, inst_idx, regUVD_STATUS);
 }

 /**
@@ -1666,6 +1681,11 @@ static int vcn_v4_0_stop(struct amdgpu_vcn_inst *vin=
st)
        /* enable VCN power gating */
        vcn_v4_0_enable_static_power_gating(vinst);

+       /* Keeping one read-back to ensure all register writes are done,
+        * otherwise it may introduce race conditions.
+        */
+       RREG32_SOC15(VCN, i, regUVD_STATUS);
+
 done:
        if (adev->pm.dpm_enabled)
                amdgpu_dpm_enable_vcn(adev, false, i);
--
2.49.0

