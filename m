Return-Path: <SRS0=FlJ6=I6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F09AFC433ED
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 12:27:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A43296112D
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 12:27:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A43296112D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61A096E131;
	Thu,  1 Apr 2021 12:27:18 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB6276E131
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Apr 2021 12:27:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bBzsUBAMvX/URscrcfWMecY2HeDhDsMRqWdzgjfkfubQeg3o0+U2uYGWJnhxKxNsKJsdNm0jDhjB7NLLPfDgmR4FBGqs3peT5IAwwT0ljkt9mtzM1L9InPH5wWL2Xcb9Td8JO+osRyTb4n5cqN0uxgHGNOwSA83d4GMDc0PrCrLAf4x9pN8OzyYt+hRJXu7bVdDnIY7ze1xtZbU9JWTCVjtj5M9mzFExK17ogCJrFp992FpmfJMqrpEIVdtZcrJRFAh1Oles8Ks4dblIav6grGdKTXzt4HINidyOeE64MI/cMJ3BgmjOWW50YFq/k636hgCoC+PEMp0mWc+OHk6nmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X/3s+CihcsMQ4HEKVHgUU3itE/eExvZJvQuQRBL1nqA=;
 b=iJuQvwdM0Z3IIkF28Ty4fbiCN4A48uHvUhrHyWXt/BPLq8Kr3kGF9VbJUt64QcNwOJ2Wmd5hs9mml5Nwn+JZNeq7bNSrOt740i45m8sgFI08v6gogo/2ClfJZxKw0+kgzABUHF9elViNcHyl8BFp1nV67sB5hP7UCZYr0JY3PdtEpzyfZ4SXl9vMNNSoy5jXbTuPK/SbCtAKf8aimrwuDfRJ2a8ozUnlsojs4iSdVQNNIeBq3e/z4s3DqiiL73KbEstimUBZFQp6XsDB3jhBQazvR8N+41vtkGX5x6FeNQKgKJoCW2qci4lp2Vy9PZxq4aXW40WuJWelI35VfdBZGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X/3s+CihcsMQ4HEKVHgUU3itE/eExvZJvQuQRBL1nqA=;
 b=wxexjb6cE18bPYUpBY5YNr2yMl/8VitIuDdPbOnDyBM4DP2aM65FxdzdIzdLggF6qJxJbuWREG9Ys0m/pYQpAw3b2rqhWbLWszNTNBRhCu+nthSFRY0FpjZOA56qvMTccSjMWErsljqXVzL1eXeVDLPs0ekNsA/J0tkKXuu/Joc=
Received: from DM5PR12MB2533.namprd12.prod.outlook.com (2603:10b6:4:b0::10) by
 DM5PR12MB1531.namprd12.prod.outlook.com (2603:10b6:4:f::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3999.26; Thu, 1 Apr 2021 12:27:14 +0000
Received: from DM5PR12MB2533.namprd12.prod.outlook.com
 ([fe80::9858:1263:9afa:4401]) by DM5PR12MB2533.namprd12.prod.outlook.com
 ([fe80::9858:1263:9afa:4401%7]) with mapi id 15.20.3933.039; Thu, 1 Apr 2021
 12:27:13 +0000
From: "Li, Dennis" <Dennis.Li@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH Review 1/1] drm/amdgpu: support sdma error injection
Thread-Topic: [PATCH Review 1/1] drm/amdgpu: support sdma error injection
Thread-Index: AQHXJugXVoeo3HPFY0icUCjJgWgNOaqflmJA
Date: Thu, 1 Apr 2021 12:27:13 +0000
Message-ID: <DM5PR12MB2533215A051551E2134E138CED7B9@DM5PR12MB2533.namprd12.prod.outlook.com>
References: <20210401111344.29431-1-Stanley.Yang@amd.com>
In-Reply-To: <20210401111344.29431-1-Stanley.Yang@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-04-01T12:27:02Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=c4d6f869-124d-4edb-a0e0-4ad1bd87f54e;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6477d488-e632-4b2d-52a1-08d8f5097afb
x-ms-traffictypediagnostic: DM5PR12MB1531:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB15317E5F756534E45A03C28FED7B9@DM5PR12MB1531.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:229;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E1PBKbVtYfSU/gvG80lMSCwii3uMcXRBzMG0oHgEUmoxXQf4B/nx6UlpnKwmYJ/8cuSj6TY+H2vnZXxeKDMjwxp0arZxbWmOEBCNze89e2FGsa4DuEhSN/VNQoPswbPxapJZVGm6IUQJ5wcDhb0VGnk2BoQIoSdKZt9PNjhmkNSwTjE0mzVMgmzKjMxymUu3GHhqrgEj05wPJKmZRGMhu2rlTWVWREhE1HY6XbApYAab/4uaXkww9va6PLR3qgsQ5A07el/rrPCz7ihVFZCa+rBu975CehQWMGYjTObCU5hYRQ/cQI+50soiyJJ6PCsy5JGiu6hFeSTZeNcffvGUtLLMvdJZzEEsTi1/F98w4iYGNPSDzb4+NAuKIWi79OASNz4e9iDsFqpwK3SR9/kSxdgiO3cyxTfUVBVKREYowMbu+8diUIk9nMPO1MUZlg598dxZnT7uOqvUqGy6Tch3nL2v5mEYST8mNXlcnC/WLgZofXWCNIX9l0Cexm1lbXde4cCuuxWr4csAyxMtUBQfYse7bw2kYYiwvko4W4wF3P6BCs/WjfBiougvY+SCheFuTcy6x8ydKZEfnchOfPCg5m1eEVA5DRAUelf4fj/JjH2t1+tqjlxS4bNApI9/NIeaXZoKuNlPmFa0fBT4+69KjGT8OJ/zmCK5bujY9JAKqf0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2533.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(346002)(376002)(39860400002)(136003)(186003)(26005)(52536014)(4744005)(66946007)(33656002)(5660300002)(2906002)(110136005)(54906003)(64756008)(66476007)(66556008)(66446008)(76116006)(316002)(6506007)(478600001)(83380400001)(53546011)(86362001)(38100700001)(7696005)(8936002)(8676002)(55016002)(9686003)(4326008)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?cUVUczdTbUFHek9paFJQWXEra1BvQ2kveVZTRXphaEZVb0lmOXUwbVRUVWRp?=
 =?utf-8?B?MkxiQ1greHJLN0lWQ1lrYzlCdWdmQzBtNnBONWpaZVJ6enA4TG9OajZSYnhZ?=
 =?utf-8?B?dEg3NkRxRkMvQXZ1OGdFaWF4N1dYYTZwN00xVlRYSk9Vd2pIWHBGQ1RoaUtx?=
 =?utf-8?B?M1N6aXdGZU1halpsNkpjVWdneGVBNVBLdmRrZmJJbGhpNnltMlQ0Ky9HMWQr?=
 =?utf-8?B?RHVqVHFkSzdvSG9iek5EaDBWcnJKU3RUTnAwR0VJNkhTZVdCK1ZwdTJaSlVZ?=
 =?utf-8?B?aGMwSTliZEEzNEJTMTk3RnBJYW05STl6TE9CTFhza0dvVHFFd0t0ZFU0dmp1?=
 =?utf-8?B?QU5pdG1JcXZ2c0xReUJBQXVPZ0RMTmV3WTNnOEdlU1JPWC9FMHRGanhQL0xM?=
 =?utf-8?B?MmxyZHZ3bmNYZThrYkxUU1Y0MjFYWTRXaytpWGI4RzVCd0V5OWlaYjB6bGkx?=
 =?utf-8?B?MXdGeDhranFaay9yWDJOb3VIeEFHOWd3UVU3b3lkbHpsVHFOY3dtREc5Rkg1?=
 =?utf-8?B?K1MzOEU4ZEhqRXp0S2JsMThtMmx1dU9yTDZ5VEVwSnNpNllhVy81RGV1SFRu?=
 =?utf-8?B?ZFFJWmFwUGhFVmlwZEM1SUI4aDBOMjJ5NCtyZ2VrL09tcFVjVTllKzRDVXIw?=
 =?utf-8?B?aEZxMWwyakdDbENBUklEanRSbUNTVVNXdjhkNW52dzduRU9mdFl5ck9iWlpB?=
 =?utf-8?B?YXF3ckhlYThkQ3NGZnk3SEM1NWJoOFBxeGtOMURDQm1abDF2UlQrSS9NQ3Er?=
 =?utf-8?B?Z25sQzRmbVQ0Zk9kUnBWclFDdkNmSnoyeEo2TFZtejAzNmcxd3gvNGtGakdR?=
 =?utf-8?B?ZTFwYVpYTlZIWFcxZkRyVWdwcCtKL0NKRldWSmgrcVUwMFVmbjVKVGZBYmdH?=
 =?utf-8?B?SFFuMStmS0hvUzRnTXB6cEoyLytBb2RXZkc0N1RlRm1renREeUlyM2s5NERa?=
 =?utf-8?B?aFNrZVFRb1NJd1dwelMwYWk3enhWYWpqd2oxbkQrbmRTNjdYS045SEYyTlNp?=
 =?utf-8?B?Vkt0UWRFZlVuQTR5MDNCWFVDckpGRUxXd3RzTnNCMW1Ob3Z6a3l5VlBRQTl5?=
 =?utf-8?B?R1lXakJtcGQzUWtxUnF2KzNEdllXazlrMUtLdnFGYzNXYWh1VnlXb2Z6YUNJ?=
 =?utf-8?B?TERmTUtMaGVuenRQWDY0d0tORCs3c3ZuRlNUR2R4OXdQSFlUUXRFWjJnNGh1?=
 =?utf-8?B?TzE1UC9DVytMdktnQWpZSFhUMHQ5M3BabzRZaGZvYTk5SlJyb0ZpMHNWY2Fv?=
 =?utf-8?B?QTlESG44M0xBZEFTRUpkZ2VHdTJ1ZE1kTmVCaFJLQzZpWUt3NjI5R3ZndmF1?=
 =?utf-8?B?c0UxQmNhTGRrbTZmYm1BYnVRQWl6dlJCMDMxM05kTjltQ2R2dEhEMXd6OGRa?=
 =?utf-8?B?UzAvS2lGZXAwZGtBeGxoZGxsUkFSaXYrTlRIL3o2RTJESTQ0MGJKUzdnNGRU?=
 =?utf-8?B?Z2d6SE95VTIvUTE4WURabjI1Zk1ZeXFha3BNUkdYSk5vRWFZUlpNVmFOZStU?=
 =?utf-8?B?eWxNOEs2dEN2UEczQjJoQmlvT1EwSVlqUUJXTWt5cStGalR4Q0lwU3hvSTlh?=
 =?utf-8?B?cmRNRXJjb2Z5Y0YyVXB0TDRFRURGVmhTUzc0S0dITFVzanV0RmtxTVVESVhp?=
 =?utf-8?B?L3U1K0ExNGZIbnJLZUxjK0lrS1VTMElCVHY5THNjd3c5aUZ3T2FoQ25sY2hC?=
 =?utf-8?B?ZHF1WW5mRHduTTByTkprbG5IbWNCaDdHaVJOdGVlVFNIRjF2YlVCL08ybExl?=
 =?utf-8?Q?Lf6nt1vCtvanNgs+aqg/LJVG08i0bB9nE6Qq+YD?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2533.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6477d488-e632-4b2d-52a1-08d8f5097afb
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2021 12:27:13.7948 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /rXyduTn94q5dToGXyE/GnnJLAgA6dAehCXym9WDxRWHkvWDeMYddikPNnHMBYXK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1531
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
Cc: "Yang, Stanley" <Stanley.Yang@amd.com>, "Clements,
 John" <John.Clements@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reivewed-by: Dennis Li <Dennis.Li@amd.com>

-----Original Message-----
From: Stanley.Yang <Stanley.Yang@amd.com> 
Sent: Thursday, April 1, 2021 7:14 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Clements, John <John.Clements@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>
Subject: [PATCH Review 1/1] drm/amdgpu: support sdma error injection

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 0e16683876aa..d9d292c79cfa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -927,6 +927,7 @@ int amdgpu_ras_error_inject(struct amdgpu_device *adev,
 			ret = -EINVAL;
 		break;
 	case AMDGPU_RAS_BLOCK__UMC:
+	case AMDGPU_RAS_BLOCK__SDMA:
 	case AMDGPU_RAS_BLOCK__MMHUB:
 	case AMDGPU_RAS_BLOCK__PCIE_BIF:
 		ret = psp_ras_trigger_error(&adev->psp, &block_info);
-- 
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
