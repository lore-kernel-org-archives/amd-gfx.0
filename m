Return-Path: <SRS0=SLyk=H4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B5BFC433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Feb 2021 04:50:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7325364E7A
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Feb 2021 04:50:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7325364E7A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB24C6E8E4;
	Fri, 26 Feb 2021 04:50:46 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 451116E8E4
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Feb 2021 04:50:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MACWPviSy3LWvpTpIvWUJZbz9pyuDW8HCpZXibmujzEd6rxhCM6BH6DDQhhdgLWS5fzLFDkEO9bvv4cGkSGp/lFXRNu2XdTtQmzsnJ3Rk3oWul7/eb7Yc8Y+t0eLy//oS0VU8fR5srVAUwh+KDRPHAp7SrKCvc9YQWikVvYirrNFK8xPzW3N6ROJdXbnbxBBfVfbN+JmYNLsHX1bfYYnra7nfMQPLW4/onTWsBJrlmtTBlRX8tTelmtv1iiI5wsOqoq1tJLJY8UJMK6b3hK5Hmq295eB0X641l1iH7LwgjGyPMMYc2/u+nuLdzxbfcY/k7zc91BkTTt9r7eVcqN5Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=alNmFFwjinaTa0GUKRI3s9/CYSapG/v63aokazRRnfQ=;
 b=DXgqFQpaj708aPotG3H0UTzijApW3Fd2afV+QJ9HPtbArKA399aH41OizJgfgoDmDkNuHD0C45zfy6v6yPq5ZHIaW6Cl/i3xDhEXcxYR6QP54d3rbHA8WlKh1Vjo0b6cWR3naQdv07OnFVCZyvXWYMLNuIWUw4X+tBjVfGhVYMxbTX342G3vzcse+DRMz+9W7GU0A13KqnFI2uLA09kr6fWloOLbs2TGILUREIxv+St2z6a3km3e+UbLZ1t0z6VxWB6hsINlhMyglW8HgkFxaW8shRxXtKBzAAUzBmiq3k6teqsT78LGNgJ5X0v0h06UaslpYCyL9YSd9pJJ5I/SkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=alNmFFwjinaTa0GUKRI3s9/CYSapG/v63aokazRRnfQ=;
 b=DTzCgX14zKGw4v3PTJacnE9/2YiHifOkDWNLsM+WxMSmLva9NXgrsoAibRjMiOUmvgCxhuSOf+ua2BNOQOTqa/YZsowI0m+EbX9E+LzmwU1x4pObrcJS76BosO9em89xdqVAqf3Eb5StlC2MAerb1fKhJ4IBCoZ78XuPuwXJCkQ=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1162.namprd12.prod.outlook.com (2603:10b6:3:72::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.19; Fri, 26 Feb 2021 04:50:41 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::11e6:53ff:8e98:31f0]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::11e6:53ff:8e98:31f0%3]) with mapi id 15.20.3868.032; Fri, 26 Feb 2021
 04:50:41 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "S, Shirish" <Shirish.S@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] amdgpu/pm: read_sensor() report failure apporpriately
Thread-Topic: [PATCH] amdgpu/pm: read_sensor() report failure apporpriately
Thread-Index: AQHXC406cKc/uj37DUeQYHiQ4X9V4Kpp3qMQ
Date: Fri, 26 Feb 2021 04:50:41 +0000
Message-ID: <DM6PR12MB26195F46A7E65A55F31EB5C2E49D9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210225154454.3644-1-shirish.s@amd.com>
In-Reply-To: <20210225154454.3644-1-shirish.s@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-02-26T04:50:34Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=2bd0b79f-21f6-4091-b12e-be87fb84c1e1;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4f206354-9d86-4c76-f25b-08d8da1211a1
x-ms-traffictypediagnostic: DM5PR12MB1162:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB11626E7AAEEBD7446D73027CE49D9@DM5PR12MB1162.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:178;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jzuCCDhWzzEmQYQ0xFWPJAQ1fu3f2Lu/zbVGyk/8DJ85UfBesFIaZ6QBeSqgp596s7fvug9hk9x9BadHLsua68UsLb5GfT0WplUOKGkIQL4bLbPzqM5Nbug/5VmE1XwdjgF8zKZormRmv6DK+TaF6ZztPRmDKTD1Uui8DgA6/df6S+/h3reVfdvNYjd18KJKL7oLMA1jif0PpdV/WsPG3Q6Xi0Lrsb4uUC9oahChEWy4iHv7jlsnaYvMqTGvH3RfoG/8k1lTSBP+gotAEgg7uc48UuF9H0UKNcS70vFjWw10jcofsF3MDfjzk+XOMwV4Q0rNN7K/w4Or+W6fIb02UG/RROAg1q2x/QLyZWWtZHiZZ/y/QUh7g81Bqc9nrIfU+zQKI1UGDHBxnk9VE9bF4LBou/7UpSgmRNuwhuV/VFZggELBjilyAuFcuCBn9YhPUWI3b+LsW3e3XaonJcFTIIFuw5rDtDS5V/N8coZup7naadJu9ofvFJoJjEbA6J056CfQHUUdkkP8g6V94v7h0CHq016rprllC0j/dvK8qbirVBNUE47YSod5vNqnUC/6
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(376002)(136003)(346002)(366004)(76116006)(66946007)(66446008)(64756008)(66476007)(52536014)(66556008)(2906002)(186003)(86362001)(26005)(33656002)(4326008)(9686003)(478600001)(83380400001)(45080400002)(55016002)(966005)(53546011)(6506007)(8936002)(71200400001)(316002)(5660300002)(8676002)(7696005)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?krNF5TAd/bSaJJkJDtW/3qv5QJ9F4oBTiuGEdjX+gHqJYew/ht2z9zDYd+pW?=
 =?us-ascii?Q?yhIlXWAtDAPcXXvwka3KxLOpNGwOTrz0wpUz3Hu1Go3euwZbgfVafrWDYAtY?=
 =?us-ascii?Q?F1CJ36Gf8/ftu7zG0dO4kNQR1WG+RN1kX8cYUxGMhgPMUwZNWt85d+GwWbip?=
 =?us-ascii?Q?2inpv8m25ccxW3gKNsR6MgX/ttEklL8xVT04Jt/5ZjUer4iOtnHFqG2tj/+f?=
 =?us-ascii?Q?FKQLvamndmH03pHbFyyaaZ8SCVW8bXEteF8eFTv7KXFHC0XRGz39823E+Nh8?=
 =?us-ascii?Q?YRmtcVqhmdXbYFyBXAOqAP1+f43jnIujWjZHfyJEI2JGgWCvKqlw6lWk6qqn?=
 =?us-ascii?Q?aWbzNV2azLxiXquIosTt8wQQcj5uGJS6PMaQ7AqXcTw8oEKKKc64EEKBZ8ug?=
 =?us-ascii?Q?E8DEeZzZkTKZ4GrX5gyQpwaANf46iojvDNsm51/15SwvE4GyE/k35PoEVWgR?=
 =?us-ascii?Q?GCQmrDXp1igtvV/V40nR8ZXx3iZHZsG+myA+VG6GqNtQakDOBY8SDzRyVdek?=
 =?us-ascii?Q?H7DWIAQjZFG1fsCVFCOZ2e19yToWxE2uPrhJATnraUgEFMl8EVdjrZqq5zk0?=
 =?us-ascii?Q?z9gg9UPXvxL6SCJdASwJ3E8ZAuIo8iUywdvgbji46p09r0BvjX6vWua0NCWt?=
 =?us-ascii?Q?yuOd06nCSaquAa4zbaWC4riDkkKC8MRx3maN+fb5n69U8Kai9aEyzauxMAy/?=
 =?us-ascii?Q?/YfD6F0uVT9ggYoH5OK7Olshbftw95B/preEPJ6ddwf9TmendQvLj7F+8aZt?=
 =?us-ascii?Q?SSjA/WOLIKpn+k6PVZxd6ZC5wFEVzj/APCO4X6k/R87G5+fpi2yYtbLQxafN?=
 =?us-ascii?Q?vUK232P1tEFfZoFLp7lYE56oWjIkjCkRIdbKy3dXfex+tvuHRIXyiUGd/1cv?=
 =?us-ascii?Q?SRPfCWt7YmyQdIfVgJoaJ5pJnv33EMuyMdQJnooh12BAS1urd/R81Gl9w4x8?=
 =?us-ascii?Q?c4M2cOIEmftuTGrx6je8/yV4wtcImcxprAxnAdn0ln4tT9Sv/tbdiSoF53Mq?=
 =?us-ascii?Q?72tiGjRW9fzwfR1wCZpAxGwxkQJrGrvO1r+aYZ+XrzM9aTgU335REReTBzGw?=
 =?us-ascii?Q?NsVIrHa6zM8QDJycb5XUCuLiHgUgUW6/1cOF6Uiy0NvLaUKdthNGFc30uE+P?=
 =?us-ascii?Q?+0240NsPh+6XXkM3I7uxCaP1Hm6RQrX62UIRwZLcg1usxhTh9vZgPEsXyDwd?=
 =?us-ascii?Q?sToJeVyBe0CJS1EW13pZKxK8hXcqYkTgP7FYG6wb28zcz1aSDB4VM7AmoZjU?=
 =?us-ascii?Q?UzskvFejrERO7QSgFR6aqJRpVA9Wy2VfWuP7uD6bpM4JFLqnneb1DExOt1Ax?=
 =?us-ascii?Q?IwqhjksDL52QvECrDIN/LXT4?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f206354-9d86-4c76-f25b-08d8da1211a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2021 04:50:41.2278 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wEgzHLWQkZ/vt1FzGMKdaoC0cxfvDyqrR4lYoK/zNnxtdPLyKx2vDnE4FafdlXG1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1162
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
Cc: "S, Shirish" <Shirish.S@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Shirish S
Sent: Thursday, February 25, 2021 11:45 PM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-gfx@lists.freedesktop.org
Cc: S, Shirish <Shirish.S@amd.com>
Subject: [PATCH] amdgpu/pm: read_sensor() report failure apporpriately

report -ENOTSUPP instead of -EINVAL, so that if userspace
fails to read sensor data can figure it out the failure correctly.

Signed-off-by: Shirish S <shirish.s@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c  | 2 +-
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c   | 2 +-
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c   | 2 +-
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c | 2 +-
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c | 2 +-
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c | 2 +-
 drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c             | 2 +-
 drivers/gpu/drm/amd/pm/powerplay/si_dpm.c             | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
index 2c90f715ee0a..c932b632ddd4 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
@@ -1285,7 +1285,7 @@ static int smu10_read_sensor(struct pp_hwmgr *hwmgr, int idx,
 		*size = 4;
 		break;
 	default:
-		ret = -EINVAL;
+		ret = -EOPNOTSUPP;
 		break;
 	}
 
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index c57dc9ae81f2..a58f92249c53 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -3945,7 +3945,7 @@ static int smu7_read_sensor(struct pp_hwmgr *hwmgr, int idx,
 		*((uint32_t *)value) = (uint32_t)convert_to_vddc(val_vid);
 		return 0;
 	default:
-		return -EINVAL;
+		return -EOPNOTSUPP;
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
index ed9b89980184..2cef9c0c6d6f 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
@@ -1805,7 +1805,7 @@ static int smu8_read_sensor(struct pp_hwmgr *hwmgr, int idx,
 		*((uint32_t *)value) = smu8_thermal_get_temperature(hwmgr);
 		return 0;
 	default:
-		return -EINVAL;
+		return -EOPNOTSUPP;
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
index 29c99642d22d..5e875ad8d633 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
@@ -3890,7 +3890,7 @@ static int vega10_read_sensor(struct pp_hwmgr *hwmgr, int idx,
 			*size = 8;
 		break;
 	default:
-		ret = -EINVAL;
+		ret = -EOPNOTSUPP;
 		break;
 	}
 
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
index c0753029a8e2..a827f2bc7904 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
@@ -1429,7 +1429,7 @@ static int vega12_read_sensor(struct pp_hwmgr *hwmgr, int idx,
 			*size = 8;
 		break;
 	default:
-		ret = -EINVAL;
+		ret = -EOPNOTSUPP;
 		break;
 	}
 	return ret;
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
index 87811b005b85..e8eec2539c17 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
@@ -2240,7 +2240,7 @@ static int vega20_read_sensor(struct pp_hwmgr *hwmgr, int idx,
 			*size = 8;
 		break;
 	default:
-		ret = -EINVAL;
+		ret = -EOPNOTSUPP;
 		break;
 	}
 	return ret;
diff --git a/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c b/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c
index 66daabebee35..bcae42cef374 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c
@@ -3305,7 +3305,7 @@ static int kv_dpm_read_sensor(void *handle, int idx,
 		*size = 4;
 		return 0;
 	default:
-		return -EINVAL;
+		return -EOPNOTSUPP;
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c b/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
index 62291358fb1c..26a5321e621b 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
@@ -8014,7 +8014,7 @@ static int si_dpm_read_sensor(void *handle, int idx,
 		*size = 4;
 		return 0;
 	default:
-		return -EINVAL;
+		return -EOPNOTSUPP;
 	}
 }
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cevan.quan%40amd.com%7Ce75d6e31cbd24543842908d8d9a45b47%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637498647228921062%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=ab%2FhxQlLALeCG6Z1hEMdu2Clxi%2FkIMAj8FZah1F1%2B8I%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
