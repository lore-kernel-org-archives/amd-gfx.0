Return-Path: <SRS0=Az3f=IU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 063A5C433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 06:12:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACC086192E
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 06:12:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACC086192E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D4E06E0AC;
	Mon, 22 Mar 2021 06:12:17 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6F6D6E0AC
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Mar 2021 06:12:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jo5YgD2X8E+Vni3DmFWL165QpSLNlDfAxloMQ20I9659DACIC/TWvfzpFQoAG/9kuBX2QEHnvo3IqXCz2+wUsprBDqblqp8G/uCls2Up54ESYenz/oLVFuqKgeBm13HSspp2SjTr07wqwDsytwFM1KLdLyeZvC7nnVk8K8acA5OM9pX1iSESpqpQOvvdNlMY1f25m9Im2GlVomzjlBUA3v5ejWjxH0V8ruBJ+xG/BKcuZE81sh1xTj0wu/SP2Cff67xB/o0rbv8CKXFYSUuAssdrwZ3wFnKPHz+I19kw1BX7goAxO59WEuzz9huNXtMOjf4ZSi7wMBtZDp1LIW4JQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VRPFFaCvJNps1CfmyoimQvNQrwAEAtOHptroDMj0Vik=;
 b=BRtu1mkDm8X0mgwC+z1d5lyygXP2P/+EMM675q1sxxLC7hsWuXJKPTFaP/h2tn2+A7D2ByXM7wyD+WECnRFQm90RalsefkHkhitniX/wlGo3FcEwYqHnRxVY1fMqzRJTEC23x7k9h0R+YRKgfzJyv7xsxity3rDH87frKm0xk2HNsRjLOZAfAMxUkVKltJOmxJKWyXYYtuymv8xAe4xg/l/4nZV5DDeMfooKQkJThUC9Ry8unF6pus+i0jqac+EKIHXseVbMbxwmQpYLba/LjB2ApKV41f1TxtrLHBhFk4rrQK2I4sdWf75S4Xbr9qA4+9yDJqqeGWBHT1rlnlg6zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VRPFFaCvJNps1CfmyoimQvNQrwAEAtOHptroDMj0Vik=;
 b=n/NwDLL/VCN07lDn2yMpLRJs/F36yXoXeErVVvI/VbqsMQn/3jLopMtZ76QDpVvxCOManGts3QcGA+WiptfONp1Gu5tNy9xe+q8FjJ6osFi3N/8DJ0PbkzjHrsS4soc8VwS6GWipJQL5MEIo7YSd0+9HN072U0LPKXSF1/5D+EE=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3081.namprd12.prod.outlook.com (2603:10b6:5:38::27) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.24; Mon, 22 Mar 2021 06:12:13 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c05d:8592:f72:bfc8]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c05d:8592:f72:bfc8%7]) with mapi id 15.20.3955.027; Mon, 22 Mar 2021
 06:12:13 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Li, Dennis" <Dennis.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amd/pm: drop redundant and unneeded BACO APIs
Thread-Topic: [PATCH 1/2] drm/amd/pm: drop redundant and unneeded BACO APIs
Thread-Index: AQHXHJ/7tV1D7BwaP0GVX8ZfbZ2zsqqLK3GAgARfvWA=
Date: Mon, 22 Mar 2021 06:12:13 +0000
Message-ID: <DM6PR12MB261924F40CD6FB751D9253C1E4659@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210319091155.537787-1-evan.quan@amd.com>
 <DM5PR12MB2533143196D7A67C08F847BCED689@DM5PR12MB2533.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB2533143196D7A67C08F847BCED689@DM5PR12MB2533.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-22T06:12:11Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=fb0750a1-5dd9-458d-a47f-bd44d22dd2e1;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 39a4080b-5fc0-4b1d-a63c-08d8ecf96fc7
x-ms-traffictypediagnostic: DM6PR12MB3081:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3081B677EBE9454759D3F37DE4659@DM6PR12MB3081.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VdF2pIV90azZ899ZanHhYJnXQ8wS+Br3Plf49IF1zlwwUJXS7BZ5vYWrvz3+rEDr+gje6EmMH8cZvnmHlcjNWCiFhA0KgnKw85S+bQ0dNomFL7jxVG4PMR8Q494xtOb9u9CP95VZiVFuJpIwRRqE++/eMaGOXViBET36Xt9PkpLsJnPe3TDrOP26SKRW1J9i7a+tiH3ZYPVQmAr96RGiXIeEfV4hf3+LCnlNkVF5WfQuAyHanXPrcEMSdGtFT4G3r1AxHF7xsWuSmGzevo8/uTkXAg1uIwBpayLWGkX9nPkyQIsTbLKO9yFrb3wmDTpMPravG/KH54jg0g3cEdU8njNUCC49bgjvpFRw+ZdS9E/okLEo/nD0NH68H4109+EuQBIe8icrRRuLA5/FFaXK+O9NuIwDGH/Iy4+KzYYo3Odyur0OvouvfRNQVmwiP4hwAnVBtkBXA+lU1RST4j7Pz6asEAEllACp1uwpIiMDisgTxvrxkQ2gqj3K+gr4aZGnLnwp3N1qcq4v9dMe52b9lQUWnG1c865oDA058CCR8RhmyNpq/PqZ7egCFHaDyoQLFbjnbDrCoOZiTpWbnWtRgFBx9REu1URHDS9vKgI6QSK9caqLd0c65XHU1+Egwq6+T4rJFzIRmI8vBw7KT6n6hRH7R+gXeGfQ7PU1FO19dozxYpuKhceYleCSHsQOm2LADgA9s+mfQPYQhl07a4Cpog==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(396003)(39860400002)(366004)(346002)(38100700001)(83380400001)(45080400002)(478600001)(71200400001)(7696005)(2906002)(6506007)(53546011)(86362001)(76116006)(186003)(110136005)(316002)(26005)(966005)(66556008)(8676002)(66476007)(66946007)(64756008)(66446008)(55016002)(52536014)(8936002)(33656002)(9686003)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?Mk4rTFBsN2xhSUErSWhsSnYyNzM5MTRnMHZ0NGJ4K0RwT2VkZEtSMWlvZXhS?=
 =?utf-8?B?UzJEYmJJVnBqU0hIZHMvVW85ZWRvUTVsbG9HN2hDNjFUcXdIcS92Y1VPejMz?=
 =?utf-8?B?ZWhGcXdNcmZDYks1NVFWTmkzY1RWQXhyZHlVOEFyQk9uYzYrWUtBQkxZQWN1?=
 =?utf-8?B?cFEycXlmc1B6ZXNGT1NMLyt6a3VyVjJ4aHBtcjdzTENUUGhkZGhWSWs1Vkhp?=
 =?utf-8?B?U1kzQXBiUCsyQUJNU05ZOEZqSXY4TTdkL082QUhWN0ZJalE1K3NDZHFkQnhI?=
 =?utf-8?B?bFMvMHFRUmZCYVNKTkE1T3kvSzJ0czUyMWlnSDliSmJsUnU1SmtXcXBya1dH?=
 =?utf-8?B?SmtNcWgzWlR0OFpZYlpTZEUxZlJtNitEYzl1QU13bHppYU9mSFQ0U1dBRmNG?=
 =?utf-8?B?UHZRdlVpZFZCMFR4RDlzZEZHYWVDMUZ6aVVueGcwaHYrOWZ2cjZVeUJnQy9w?=
 =?utf-8?B?QjZxejNJaW9iZ2VicDhGcnh1bUtld3dhTE0rWGJmYWdGYzMyRFpGcGdZeGtz?=
 =?utf-8?B?dGFuZkRzQjdZcElWWk9CdG5ON2pIdklPM092MExtVkFhQ0MrTjR3b0QwN3Vu?=
 =?utf-8?B?MnlmdW1VMnZucm1CUGt0Y0JkWnFCRVdpQlR3dVhIazVOaERTS2drWWFkR0Jl?=
 =?utf-8?B?N0J0MUg2UFdCNkFub1RWQnRJUno5NENtSHJWNU5jc21SNGxHcEovUldkVTJR?=
 =?utf-8?B?akcvQWJ5TzVJa25IbFZxQjZFYVROd0U3bGx2bFJlVXdsUE1tcFhMNmhBNS80?=
 =?utf-8?B?SmFzV1pxL3NGcmZKVVdORDIyZ2NDZ0V1TStSYTNUaFdaR0hTMVN0V0ZUMzNW?=
 =?utf-8?B?Z3FEcU10WnVQcmltZDhzNTM2Tll6WUIrR2x6NXBWT3RtNkRMU1BoVTg3QkM1?=
 =?utf-8?B?TmtMM1hJZ21XSlN3dnU3eVkwT1FEUEpOd2VEc0F4RGlWL1pmUVRLaHpFYTB1?=
 =?utf-8?B?UEY1R1dCNHBjdDY5UjZKVVhETzFkZjlmaUtJZDNRTVN2WFVhNzlSaHMrRXVG?=
 =?utf-8?B?R3lyZGUya01odERrMS9lcHdvTXRPN0VjY0ttMDB1NXlqSWR0ZUFtR3k2U2ZJ?=
 =?utf-8?B?eTdXNWk3UnQ5T1BJcVJJQWcxSVFKbGlsbkJEblhrakwxc3J4ZlRuT2ZqaUZN?=
 =?utf-8?B?dGpxNUpjV1VDcnVqY2pJYlZjV0l6RlpGQW8rMHhrWkdTSUpUaGdyY0x3NXN6?=
 =?utf-8?B?bXFrOFI4NWp5QW5OdkRiTlpROW1oMFhyb0tRbWhDSUw1WnRKRkMzZnZWTW8z?=
 =?utf-8?B?U0lQY2xqZ0xSWHRzK0JIOENNVUNLdzdyU2k1OEVaQ1lPR3g4ZHZDbmw1bk9O?=
 =?utf-8?B?V2hKNTBFdU55ekIvWVZhWXBNelhETktGcnAxejdxMGNkT3FqRSs4cFNSbWlq?=
 =?utf-8?B?YTJPNlZDdHByWTluUExGN21UUEJlQ01uRjhlVWcxUW9ReStiUUdZdStxcVM0?=
 =?utf-8?B?MUhpNVNERjhWalNnQXV0QU9ldU04NERJUXlrSyt0SGliVW5YNXFlTmQveDFY?=
 =?utf-8?B?dGk5d2pVc2t1Q0tza09hNGJRc0cwbVVZekFmeSswMU4vUmxLM0Zib1J3UFRN?=
 =?utf-8?B?V29wWndGeWlMc09zT1R6M3dFcDF0UlFHMkJnVTFHN0Q0Y294cWtrbmt5Z256?=
 =?utf-8?B?OURKam1zOW5aTHZ3WDBEenBDdGo0Zk5tTjlTWXVlK3lsemgvTWFBKytQTkFM?=
 =?utf-8?B?RXNRbGwwVlMvT1RRampRdTBJcW1tbkl6ck1oOHhmQlNPUEF5ck5GUGVmNTg3?=
 =?utf-8?Q?leLG3IaaY/dHVg4vyVG5uMEFT2OgmLu9QciRGHE?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39a4080b-5fc0-4b1d-a63c-08d8ecf96fc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2021 06:12:13.8452 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DhYdbWAp9s0dMmZUWGy6TpAPm5yiAl7voixTzd0EyAuymSJrJkc0TyyWbDnr0+bS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3081
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Thanks Dennis. Please check V2 with that updated.

BR
Evan
-----Original Message-----
From: Li, Dennis <Dennis.Li@amd.com> 
Sent: Friday, March 19, 2021 7:24 PM
To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Quan, Evan <Evan.Quan@amd.com>
Subject: RE: [PATCH 1/2] drm/amd/pm: drop redundant and unneeded BACO APIs

[AMD Official Use Only - Internal Distribution Only]

Hi, Evan,
      It is better to replace all nv_asic_supports_baco callings with amdgpu_dpm_is_baco_supported, and remove nv_asic_supports_baco function. 

>>> static bool nv_asic_supports_baco(struct amdgpu_device *adev)  {
>>> -	struct smu_context *smu = &adev->smu;
>>>-
>>>-	if (smu_baco_is_support(smu))
>>>-		return true;
>>>-	else
>>>-		return false;
>>>+	return amdgpu_dpm_is_baco_supported(adev);
>>>}

Best Regards
Dennis Li
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Evan Quan
Sent: Friday, March 19, 2021 5:12 PM
To: amd-gfx@lists.freedesktop.org
Cc: Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH 1/2] drm/amd/pm: drop redundant and unneeded BACO APIs

Use other APIs which are with the same functionality but much more clean.

Change-Id: I5e9e0ab5d39b49b02434f18e12392b13931396be
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c           | 20 +----
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h   |  9 ---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 95 -----------------------
 3 files changed, 3 insertions(+), 121 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c index e9cc3201054f..2670ae00c2e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -517,19 +517,12 @@ static int nv_asic_mode2_reset(struct amdgpu_device *adev)
 
 static bool nv_asic_supports_baco(struct amdgpu_device *adev)  {
-	struct smu_context *smu = &adev->smu;
-
-	if (smu_baco_is_support(smu))
-		return true;
-	else
-		return false;
+	return amdgpu_dpm_is_baco_supported(adev);
 }
 
 static enum amd_reset_method
 nv_asic_reset_method(struct amdgpu_device *adev)  {
-	struct smu_context *smu = &adev->smu;
-
 	if (amdgpu_reset_method == AMD_RESET_METHOD_MODE1 ||
 	    amdgpu_reset_method == AMD_RESET_METHOD_MODE2 ||
 	    amdgpu_reset_method == AMD_RESET_METHOD_BACO || @@ -548,7 +541,7 @@ nv_asic_reset_method(struct amdgpu_device *adev)
 	case CHIP_DIMGREY_CAVEFISH:
 		return AMD_RESET_METHOD_MODE1;
 	default:
-		if (smu_baco_is_support(smu))
+		if (amdgpu_dpm_is_baco_supported(adev))
 			return AMD_RESET_METHOD_BACO;
 		else
 			return AMD_RESET_METHOD_MODE1;
@@ -558,7 +551,6 @@ nv_asic_reset_method(struct amdgpu_device *adev)  static int nv_asic_reset(struct amdgpu_device *adev)  {
 	int ret = 0;
-	struct smu_context *smu = &adev->smu;
 
 	switch (nv_asic_reset_method(adev)) {
 	case AMD_RESET_METHOD_PCI:
@@ -567,13 +559,7 @@ static int nv_asic_reset(struct amdgpu_device *adev)
 		break;
 	case AMD_RESET_METHOD_BACO:
 		dev_info(adev->dev, "BACO reset\n");
-
-		ret = smu_baco_enter(smu);
-		if (ret)
-			return ret;
-		ret = smu_baco_exit(smu);
-		if (ret)
-			return ret;
+		ret = amdgpu_dpm_baco_reset(adev);
 		break;
 	case AMD_RESET_METHOD_MODE2:
 		dev_info(adev->dev, "MODE2 reset\n"); diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index 517f333fbc4b..02675155028d 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -1285,15 +1285,6 @@ int smu_get_power_limit(struct smu_context *smu,
 			uint32_t *limit,
 			enum smu_ppt_limit_level limit_level);
 
-int smu_set_azalia_d3_pme(struct smu_context *smu);
-
-bool smu_baco_is_support(struct smu_context *smu);
-
-int smu_baco_get_state(struct smu_context *smu, enum smu_baco_state *state);
-
-int smu_baco_enter(struct smu_context *smu); -int smu_baco_exit(struct smu_context *smu);
-
 bool smu_mode1_reset_is_support(struct smu_context *smu);  bool smu_mode2_reset_is_support(struct smu_context *smu);  int smu_mode1_reset(struct smu_context *smu); diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 4120d28f782b..1bb0c0966e3d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2682,48 +2682,6 @@ static int smu_set_xgmi_pstate(void *handle,
 	return ret;
 }
 
-int smu_set_azalia_d3_pme(struct smu_context *smu) -{
-	int ret = 0;
-
-	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
-		return -EOPNOTSUPP;
-
-	mutex_lock(&smu->mutex);
-
-	if (smu->ppt_funcs->set_azalia_d3_pme)
-		ret = smu->ppt_funcs->set_azalia_d3_pme(smu);
-
-	mutex_unlock(&smu->mutex);
-
-	return ret;
-}
-
-/*
- * On system suspending or resetting, the dpm_enabled
- * flag will be cleared. So that those SMU services which
- * are not supported will be gated.
- *
- * However, the baco/mode1 reset should still be granted
- * as they are still supported and necessary.
- */
-bool smu_baco_is_support(struct smu_context *smu) -{
-	bool ret = false;
-
-	if (!smu->pm_enabled)
-		return false;
-
-	mutex_lock(&smu->mutex);
-
-	if (smu->ppt_funcs && smu->ppt_funcs->baco_is_support)
-		ret = smu->ppt_funcs->baco_is_support(smu);
-
-	mutex_unlock(&smu->mutex);
-
-	return ret;
-}
-
 static int smu_get_baco_capability(void *handle, bool *cap)  {
 	struct smu_context *smu = handle;
@@ -2744,59 +2702,6 @@ static int smu_get_baco_capability(void *handle, bool *cap)
 	return ret;
 }
 
-
-int smu_baco_get_state(struct smu_context *smu, enum smu_baco_state *state) -{
-	if (smu->ppt_funcs->baco_get_state)
-		return -EINVAL;
-
-	mutex_lock(&smu->mutex);
-	*state = smu->ppt_funcs->baco_get_state(smu);
-	mutex_unlock(&smu->mutex);
-
-	return 0;
-}
-
-int smu_baco_enter(struct smu_context *smu) -{
-	int ret = 0;
-
-	if (!smu->pm_enabled)
-		return -EOPNOTSUPP;
-
-	mutex_lock(&smu->mutex);
-
-	if (smu->ppt_funcs->baco_enter)
-		ret = smu->ppt_funcs->baco_enter(smu);
-
-	mutex_unlock(&smu->mutex);
-
-	if (ret)
-		dev_err(smu->adev->dev, "Failed to enter BACO state!\n");
-
-	return ret;
-}
-
-int smu_baco_exit(struct smu_context *smu) -{
-	int ret = 0;
-
-	if (!smu->pm_enabled)
-		return -EOPNOTSUPP;
-
-	mutex_lock(&smu->mutex);
-
-	if (smu->ppt_funcs->baco_exit)
-		ret = smu->ppt_funcs->baco_exit(smu);
-
-	mutex_unlock(&smu->mutex);
-
-	if (ret)
-		dev_err(smu->adev->dev, "Failed to exit BACO state!\n");
-
-	return ret;
-}
-
 static int smu_baco_set_state(void *handle, int state)  {
 	struct smu_context *smu = handle;
--
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7CDennis.Li%40amd.com%7Cb00f935cbf75466856f508d8eab71ff8%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637517419531562871%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=J%2FeyHZ%2FPq2ASS5faBddw7PhJh%2FA2Jep4gKnbZ1J122I%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
