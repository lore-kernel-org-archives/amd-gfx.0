Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69629C4332D
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:21:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F89964EDD
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:21:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F89964EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BBF36EB85;
	Wed, 24 Feb 2021 22:21:50 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48B686EB7E
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:21:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YSLKQmiHZSUN/DA+emAGRARTux2JT24MtyOYNm2kqCNDW4AkPsSFFyz2+QlNSD2G4x7SfVsSS0U5hLMg0I9OolzDw6NUI+EZ5D9HuKuzYCB1M1hguTH0oVnZlcX0cC1ZL+LPrp+f5pdOrfMusPaTFXpjqlBq1T+OV7Ev0nU2tt/UfOlINlCmCrMeyTP+HQVmw45iHYcSESk+Y6Vw+mnIHQVxhFIFRgJEsZ1KvQPoGJz68WghLFzDr1rjk5cPbLUW6JeYHo9ybg9t3rRtp5ZnOJf+l923246h2uS2sZWDL7y9V2wvaNOo4G0DmDbmOvJBFTARnrK+FrciZCzJKYT9ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F8+EnZR3yjeDbwNHlu6rWemA/EoJllZoKiHXRWcE7KQ=;
 b=bR//Uc4gW3IHyomws2oVZ3VGLojiCpWqAJOpql63hJd5Y29uaNySLb9uDGQakQfHATmQLYrw3+34AyLzxJGH6/PmvB0RWM9Iu9Y8KOqzLzFjpxwoaIzm1KISTCyPJAdHxMTFPlTvvDBbSis+fu1dJvwPpWpuJEb7ocWtQAvx1DG7Y43imQU/Dud5ektYfI5icYDfTFn9CjKOfr5kotVSF4RRJBqLgjjBr5K4J9ZTHBo9kAppf2WKVFWHj3mxsyf9+xGi1A8E6qaT+K/PIQCvcT4c0J6OLKD6Fp2TCcT3p7RAH2GPeyqCQ5Ux10FfhRZ9hbxuBU2w4I1YKVA0CgcTaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F8+EnZR3yjeDbwNHlu6rWemA/EoJllZoKiHXRWcE7KQ=;
 b=VBZurPIGnnfFVjrRV1FvtC9VPp6I0t8CQWCVMqwmATaAQZTv7K5th/EGkVSmgXm6ggsvARLp6MaPUL6HEVpVDUOzxDBBb4IvWrKIL0HKFrIq8LEO6jd2+i2MSqEou8U+jEyGEN7xdXZTslrrhC/v59m2PqjwAtv2E+yjUbZlB5g=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4798.namprd12.prod.outlook.com (2603:10b6:208:3d::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.33; Wed, 24 Feb
 2021 22:21:44 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:21:44 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 105/159] drm/amdgpu: Enable swsmu block on aldebaran
Date: Wed, 24 Feb 2021 17:18:05 -0500
Message-Id: <20210224221859.3068810-98-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224221859.3068810-1-alexander.deucher@amd.com>
References: <20210224221859.3068810-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.246]
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Wed, 24 Feb 2021 22:20:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ce75deee-5846-4b06-651a-08d8d9126859
X-MS-TrafficTypeDiagnostic: MN2PR12MB4798:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB47981DEF4B70108D441E1B2FF79F9@MN2PR12MB4798.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:252;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fuu8DhDNczWke8PDj7kwP6HGvi7rtwfhL9s72m8ji6jXIPHboZx+onCcSZ85CvoesD1lgouLNT0G3VFSDRYCQY3NoT9LcNSWfc4h5dUCKdEe3RJ7BY1B5sYfCju/wba+eowZ2CvDzeFnXhlO/TFaEXv9eAggXQkKmDXyc0BN6gJftmSVSvGL3iizGkqaMThA4rwsNN04cx7piWSbm0eCCx8Pyt8rt/dxrJ3FF5Xk0XYQ+ajWbikIfGV+PQKm4r/1IDfzyCyjfW9/38GFzLp2pSQ23mnrCQRVnKPiAC3+2pl95rwc9HrqVdm9NgzDucDNqGb/iT33UEsZTdZWXs//xhkPKc/IJn5qxaECW65wtSj1s2xTlHfSO0Fiak/7TomFI1hJmYUz+k7iuINTRq6pJ+cEEgCOdzz5gWIzH3Pd6tVQpwXaL0wI8uFvnLb1kP8Ak/yeJub26V0DO1Qa+Fp1Jn6cbUYWmJsXidJRD/cZmyLLj5E3OdFpSUYDIvWXFJKQEKG+No/KNj/WJeoiUlPlMQOXMpbO77Y4XrWMKkpTDOPFcSfgbpCgurGMAkn6tYbTH+rumsGtndQ9Rhz5JuhbXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(1076003)(83380400001)(8676002)(8936002)(186003)(16526019)(6486002)(69590400012)(66476007)(66946007)(6506007)(2906002)(54906003)(86362001)(316002)(6916009)(66556008)(6512007)(26005)(2616005)(6666004)(4744005)(956004)(4326008)(36756003)(52116002)(5660300002)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ev4wF5bjNmyMHxtGkDisjhIcITbqqmWXw6QhKpFsOm45zy+YDQ+S0RUzWV0i?=
 =?us-ascii?Q?k2+E3yT9QUamdYOzhpNVX4KsU6cQ/7ymGMZsqINlpssQvNhGJNErVQE7/yA+?=
 =?us-ascii?Q?ghgqUfSX7/KMdUXMMOTjcGCksOclhoB0+f3h5/tARbq0/fdPo0qQy9Qtxdzq?=
 =?us-ascii?Q?PeUj2n8yfECDn4Dm5gDjueb0aUjpigejh3avX6KJTbpTGNJUTX7Jzy3HdzKF?=
 =?us-ascii?Q?Dk5w7HIqt1rJOma/JEIe8UsrHm8UBY7+BPF+TIAkfsjlzAIL1kfouNXrPUsz?=
 =?us-ascii?Q?CCcttEzOabwgWRY/aDBue59pOFALv9bcOuUnzqa1OULmRdFogs4e5Yktn145?=
 =?us-ascii?Q?hHyerBRnUjPcOq78RZupfoq85BaM30eCSh5a3oVOZyh44Zcu8PhIIb/Hytd3?=
 =?us-ascii?Q?MJ1Ac/g04GPlWj95/NmVALDVpGzVHr2Fhvwb65iEoPv/JVEygsszaxhn66ok?=
 =?us-ascii?Q?2id9Tj4s2eiFviNGoWflV91/eL+OHZJUNOpNrz2aUfGLbXeZenw8ne5EoKQS?=
 =?us-ascii?Q?h+dSxWTMrjNQhvcVNc/ZWTEe97XXD1oclh9f3QGSCZBotLInl6mB+SLoxaRP?=
 =?us-ascii?Q?22j2YMlY5jnX/yiwW27WavpyWroeGUSyRxplKgHN/egz4UiC+gjD+AkL8VUt?=
 =?us-ascii?Q?zvZ2CrXOOPSMCY5lT3cVPYluuhj7lQlCzIAaZ6yLHHLpkJO2UZ9IIgT0Mlqe?=
 =?us-ascii?Q?MsE5bsmoQc7+gG8fxk+hpiri5/6W7ZWIQLMVkicIRl8+FotOrln7XYK8g/xW?=
 =?us-ascii?Q?aMgH5/HRu9lhX8a84fXPsOgVxA32+lStL1vvULloxd7J96k/Nlsw1U4eV8ut?=
 =?us-ascii?Q?B2EeVrdLgXOfVe4AqlFo0eYmUKxh5yx2IaMVwqx/ujkyWaUm5zIFwcJzNzhJ?=
 =?us-ascii?Q?hURjS9xUgDMuniP4fU5ns7eeGBlXOwibHofyr9sZHjEbDEbR5k5fneGDPDZp?=
 =?us-ascii?Q?1gpGCCOcoBeP6iNDuzaCjIeLnwiZwxqeBLbvlpQ2iWxTdtS1eg3WUj/vM7ao?=
 =?us-ascii?Q?4iRa6khTaFM+0oQw2iOB2aNK7B6e4CrJmWoTnKxuMwdc4TX4RjcmdbYVCf75?=
 =?us-ascii?Q?19gc0AL4nEdq8OFzHxGaL6q5Cjb0tAs2wGQqiQ9akpGwQDPLWBp/7TR1WnGI?=
 =?us-ascii?Q?hOC20zpltgwOCRfqcsrN0ZpkKfm2LXbWQuy+8qbKvXSFeYl6dC5gX/ZlB0pk?=
 =?us-ascii?Q?wINn+UWuII7Mh2GyZMq7dr53fziAB+1EaEdP/atswbhQVJgDaEv0Mbf+DkEC?=
 =?us-ascii?Q?JFGoSMUX8yFFN4re56VrjgF8DYRmM7wLBjKyEpn98rfv7FuMDs8Y/F7kpc69?=
 =?us-ascii?Q?iN3Lx6YkOdwZtYFE109+o0Oq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce75deee-5846-4b06-651a-08d8d9126859
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:20:35.8274 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XMaZrhWhYbpZVuJqX+6xVeOSeHtrVMRWTNAMTJRP+58UPzxcwYn//WH/euZcjw/7RFSu2q3r9YoZGAzOgPZkYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4798
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

Enable smu13 block on aldebaran

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 8c93cf411f68..441dee71259b 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -831,6 +831,7 @@ int soc15_set_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &gfx_v9_0_ip_block);
 		amdgpu_device_ip_block_add(adev, &sdma_v4_0_ip_block);
 
+		amdgpu_device_ip_block_add(adev, &smu_v13_0_ip_block);
 		/*amdgpu_device_ip_block_add(adev, &vcn_v2_5_ip_block);
 		amdgpu_device_ip_block_add(adev, &jpeg_v2_5_ip_block);*/
 		break;
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
