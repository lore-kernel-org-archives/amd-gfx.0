Return-Path: <SRS0=OOkP=LC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75CD7C47082
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 11:04:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3126C61289
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 11:04:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3126C61289
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E595B6E111;
	Tue,  8 Jun 2021 11:04:47 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2048.outbound.protection.outlook.com [40.107.101.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98AB76E111
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Jun 2021 11:04:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gGjLiptUcpIGAJfJzGjwJ2KSrMIz85RW3qPaH4miZuHLQFpB+lKpCQgiwlWijhnlGI4RJavh+F6CiR4ZAM0osrvnjGPvogKQjE3Tv62/bryJLpi+b0Lr4Npn7tODwjvf1mAaHkqnzYaHxCeFKN9CPJR9W7oxdxWU7g30U5K0d8fwEjeCrB8ybYk7HtNk+vcvBmljLUfCjD4yB/RMEwnOh+/cHZDTwtVdBs2m6vrs9SXR5Am1g1XPgsN9kS0oUplhq+a2j4fwcDl8TG0DvswPrjOf5ZldYo4fU65IdAFi4bVwuBhVL5Y2pSFB8p+v8w8otG/au3ibXeHG2jXvqsaodQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lS/zxg11XWr56ZHaJKOM2/NDp4WSrvUfZROI+yAO7rY=;
 b=O4K2mIP1yadAC4zKygxC0wO4eLAc8oBi/ncxWJCt1qATQXAzXZQuHaHXsRXmRlbxNdyTy4gdzYhPxBtWxJZjNFdBwgWfiYH+PHdybQKRyMQBdAs75sbXg0+SFxpC7Be7R1pNkzgizOK3mejqj1EcKlCz5Ty6J7ZCdYVtyD+sRdtRBC09bRctbdTIPGhAQbxo8K0XP23A86bYQFIZ967JQK57R1Gu6MI+1HHAyQ0Kkg+Z+5iovAL3PFFzVfqBvZQozl1r4VeA/PYcnSAFIW22aSrwmmfN1tUDwh6iG2CG7g5+SjWfkoXh7mWFpZUh55oAiIaDXk/pSmIX3mpwPm/VNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lS/zxg11XWr56ZHaJKOM2/NDp4WSrvUfZROI+yAO7rY=;
 b=tCZdMMfqeyA93phJI/itfW0woICDcnRMzJBXWJ2pNGiIUgCVF7mE52OljSDJ7pa8Y7zrXMtMz0d8hZOC/VcH8AukoMMLltwuI3lcauClrgSA0PSznF8A/Sk9AMHxhuujTTsDYF51x7kKn4e05KV8R8cxCMXyX9NSeLvJEBUIZh4=
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MW2PR12MB2522.namprd12.prod.outlook.com (2603:10b6:907:f::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Tue, 8 Jun
 2021 11:04:41 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::f07c:dc0f:e7e8:416c]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::f07c:dc0f:e7e8:416c%4]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 11:04:41 +0000
From: "Huang, Ray" <Ray.Huang@amd.com>
To: "Hou, Xiaomeng (Matthew)" <Xiaomeng.Hou@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: fix warning reported by kernel test robot
Thread-Topic: [PATCH] drm/amd/pm: fix warning reported by kernel test robot
Thread-Index: AQHXW5sg14iSu3diT06uVoU3EBEdDKsJ9N/A
Date: Tue, 8 Jun 2021 11:04:41 +0000
Message-ID: <MWHPR12MB1248813E37E83160F73624EBEC379@MWHPR12MB1248.namprd12.prod.outlook.com>
References: <20210607124549.9061-1-Xiaomeng.Hou@amd.com>
In-Reply-To: <20210607124549.9061-1-Xiaomeng.Hou@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9f497da0-594e-4b5b-ada1-08d92a6d36fb
x-ms-traffictypediagnostic: MW2PR12MB2522:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR12MB2522B15969D5D5211FB6D8E3EC379@MW2PR12MB2522.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:41;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tOp0lyL390ifNYGbglo1KoQZcxi6xZfQ8YIgXkLiuEe3wDaic9+dwIL6U0THqxmHTFC4e4K8zTgRnQ+m0y/l1jddt18+tyKKU1olhJ+ia8m6QirrTiqx8VIhDcrY2C9f/6yrloCkVnDUyRlGTPEefSjjPNMIkKuF3986LRMp5EVLk+UXWkYIq0QEvY4SdK6JHbUxyxWmvlJi/1moC1na7Q0Jg6icdPf26XDPyjJcifQ+MLs+b0jBpB2nfxpymzW6WrqIy43M1+LHjs/NilroGq59fpsZVoWIfZhli/tA/4cqx2wrLmvXE8uI7AK0oQpjDIxzs+C4nSc2dQ+klXCihiEMv2ZjL1+htN7QS4jgJpbdW4jPIWYCVLAElyRuKuZbHi8r7tp+PYME1TXOL4l1Px23EFq+S5/2LcXVekJdHRYwiJUmzwT3Mgz58vCEcZzrUaYgYuYeAI85MbF1A7nE7zHKQjC6LAOhuOuteMX37paXLyTwoA5rIMMw4Uah3jZoaugt831ZRUWm5AlUs6yyUB+QUAPPnRtF7sr3YFuCRoilgBee6gEdXOR52MXY2CLYsyclk1sFIIwRbDYcFu5tn5QvRUWAEFS1nHEr65TjhDM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(376002)(39860400002)(366004)(86362001)(2906002)(9686003)(55016002)(8676002)(7696005)(33656002)(38100700002)(6506007)(53546011)(5660300002)(52536014)(186003)(122000001)(66476007)(71200400001)(76116006)(316002)(66556008)(64756008)(66946007)(110136005)(4326008)(66446008)(478600001)(8936002)(83380400001)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LolvuGKpiB4lhkKnSjMq+js6moU14qM1lx9h4uBv63lJEZoxB7gCKBpDybJA?=
 =?us-ascii?Q?pHgt7qlZoBmlx4dNuzmjO4h/6nrfaI7mPfKBVcEpMKlntBpRVI7CcrHkP/eS?=
 =?us-ascii?Q?BYBZrw3kGUUPd37XSZrIzqVTq1c4T6mV/L67sxddPCcgxzm8Db7Q4Bzayi4H?=
 =?us-ascii?Q?61tCedbju55VAud5PPXE0cbiBXqEdUcNR+xIPnClCkJsiGNdig53nLGPpLGb?=
 =?us-ascii?Q?2roUpGMn4sKsAMOQBQKS9dNMqeCF7q+KVcg3QqWjNXH7jduIRgEY0v+AgcZN?=
 =?us-ascii?Q?0wV6Fx2XYrgYrwe6LfUdblvDPUQsNiqlXiM/6ORkhtS7xmMvNy6Wtj0wOkyx?=
 =?us-ascii?Q?+8/yXzDID1NOTSv9BDLCIRtJ1OzUKk0SQDlMjVAkdF59+wCW5jQ/BmptwLS/?=
 =?us-ascii?Q?T5LP2q4EW9V04WyppbBe8cSeFGOiALF3twlJhuUfU9OwrYhVXjAYk496M1sz?=
 =?us-ascii?Q?Va0RWhE7YXFwJkrjZEdwIj2EhiKIafX+f6ZaIZZ5p3OahJn69PWeDNFfmbpN?=
 =?us-ascii?Q?T6MUTwNlgJhJ6SqcWZ9In543wN0Fji3CgJGPWdWMa12p6H8pQZbKI6rb0z5j?=
 =?us-ascii?Q?+FOq3G4pDehvnYhjtZp5S5FBWbS9jwzVFKr/lpElYI5HO/Aw81uSfwp5jox8?=
 =?us-ascii?Q?soX1MhQfbinev2UvftFGcydNniW0TTAicw6F6olmLD2FeuUypLTtmF5pCfhj?=
 =?us-ascii?Q?ZihhdQ1mvAEo3uSmEMQVPPrwP6oh8ugcrJYM5vduQLR/uulXDmoD1lRc7I2H?=
 =?us-ascii?Q?beGj9i8O4or3eADLrd1A5flj6LqnHzcObREMc8eGCuFQ7ARA4qU1Z0XByXKM?=
 =?us-ascii?Q?A5aTNx0vTPCFuZV38MV+TUq4AaZMy5dwh8BwsHVzTMLO3Q2+F/Umhuh9Dq7n?=
 =?us-ascii?Q?PhGeOTQoibUhpNoSrl3xALjONwbgbYLpO2jxmPM4yJx2mKQE0VOqj5B6WoCM?=
 =?us-ascii?Q?JST6sPgpuqTy0g3Uj+IxV8tl8lfMSG3hRGnVSY5zPSK9zvB8SQdkIBFA3eVa?=
 =?us-ascii?Q?G++QUO+8Li3JOVQQcsZS4aR9xla/JwDcFDmDRInt7So3ggQRCX3x3GWCAqeZ?=
 =?us-ascii?Q?pdvtA5CvqP/JflvkjggyhZcbDwcXDWM3Q2GMV3PWc7OHgnVeHyGIV9tNWeB8?=
 =?us-ascii?Q?eX7yZ8aTIj31XUlgMIgE6yTjrWbZ16Yi4jrcwAP5Yxy79itd0GFo7N3zedcB?=
 =?us-ascii?Q?HMkh0a9tzaYT94NJTopmwsZRcTZiTjzRuvBed9QN0L0Hty1sZIdX2MVaRTaz?=
 =?us-ascii?Q?V6ju0EUUfDGdI8nGuRYAzokU1tDyFPaNvJsSocVgrvt85GGhGyeh6ii/RRXl?=
 =?us-ascii?Q?iUKCyMaL0rXmdHATrMhtlZ+Q?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f497da0-594e-4b5b-ada1-08d92a6d36fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2021 11:04:41.0531 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V/3hEVGONk8Ld3tz04cA1JwkGM/gcrr2xfmBitg+BKe/UQMt6eGjysLxKd+e5+8O9oUfAeoVrrVZYqdRf2YFOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2522
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
Cc: "Wang, Kevin\(Yang\)" <Kevin1.Wang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Huang Rui <ray.huang@amd.com>

-----Original Message-----
From: Hou, Xiaomeng (Matthew) <Xiaomeng.Hou@amd.com> 
Sent: Monday, June 7, 2021 8:46 PM
To: amd-gfx@lists.freedesktop.org
Cc: Huang, Ray <Ray.Huang@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>; Hou, Xiaomeng (Matthew) <Xiaomeng.Hou@amd.com>
Subject: [PATCH] drm/amd/pm: fix warning reported by kernel test robot

Kernel test robot throws warning ->

>> drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/yellow_carp_ppt.c:483:2:
   warning: variable 'member_type' is used uninitialized whenever switch
   default is taken [-Wsometimes-uninitialized]
       default:
       ^~~~~~~
   drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/yellow_carp_ppt.c:487:47:
   note: uninitialized use occurs here
       return yellow_carp_get_smu_metrics_data(smu, member_type, value);
                               ^~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/yellow_carp_ppt.c:465:2:
   note: variable 'member_type' is declared here
       MetricsMember_t member_type;
       ^
   1 warning generated.

Fix this warning by return errno when the clk type is unsupported.

Signed-off-by: Xiaomeng Hou <Xiaomeng.Hou@amd.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index 031c49fb4582..0cd7902d5172 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -728,7 +728,7 @@ static int yellow_carp_get_current_clk_freq(struct smu_context *smu,
 		return smu_cmn_send_smc_msg_with_param(smu,
 				SMU_MSG_GetFclkFrequency, 0, value);
 	default:
-		break;
+		return -EINVAL;
 	}
 
 	return yellow_carp_get_smu_metrics_data(smu, member_type, value);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
