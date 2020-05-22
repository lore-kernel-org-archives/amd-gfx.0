Return-Path: <SRS0=+s4F=7E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0401C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 05:36:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80405206F6
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 05:36:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="BIOwZ/Fr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80405206F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4942D6E32D;
	Fri, 22 May 2020 05:36:31 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CC446E32D
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2020 05:36:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YGHFc80Ul4AYuUquWwS4b3wMmLE7VaamhzNfNoSjH9aYvl/IHiFn0a+q3HVWwL6VEVbO1jM196wHdzY403dfQ9HWzgeV/rABXNJaBwEzIB7t7rZQMMYgICWsFat/f/aa21x5s0N0yUtbCRwZWGXkCrKPK7GpuucjcAhliiapWSuMIaFvSgGNubZD65vubA6iJCScRbav/aQCmKlJtLtrhozr1oOTJcJh2lGB0pcxYTGXr5VgpVo8W/o9QIEjcNBDHnX/P2jXODto/Td8ruqBBptuebMeT20Dd89s0AM+aFcVG4Hnvf8FRYE5gN/UDnl/0psDnsjohvocl2Rf9Ej9hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jj08DjCH9Ije06FAjfj9pZmcK/6lh3UAHmqCNbDve4w=;
 b=OZO/Q/51St69eu4QWhe0hkmWmsphhz/cLxLmtI8XProHoDCZxQZgvGvcUZL+yPIXJMMMIhlpsI3IRrFec4CIFGz7/f+obESeVE9OGjTIfscD1lMUm4B2i+G9G0vwVqMSJhoJZePjY4JIoPD+05q/FKtyzHtKLf9yzPkMMTjFo83LK0lsfX3oYSqwugKuSNB7XezoX7dIjfH/uVTTtXqgf8JGhp6Nf+E25OXMb+C+VcMQfOC8KK+sMYzGEp372jvMRBlG/CsdEMy577tJh/hH6/6zs86a0jpqUR+X5Zy29zW00zo1AdXZ1ssC06Y0GFgp1sNU/3XI+2uCPWIBrJSXhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jj08DjCH9Ije06FAjfj9pZmcK/6lh3UAHmqCNbDve4w=;
 b=BIOwZ/FrfHbdLCUSGiafnwK9WqSdn+L/TLC2tjE2jko3z/PMnFJQN7ZlehQE7blJFZQ0UJRyKeVrEm1a2gutUt/gprpubVGn8skGblwKXS4jlFVTyLovMpfAVKC/gFQWK0/HkmMpmyrSrQQDCSV2q9lSvFa7U02Tj954wOb/4pY=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3498.namprd12.prod.outlook.com (2603:10b6:5:11a::25) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.27; Fri, 22 May 2020 05:36:28 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3000.022; Fri, 22 May 2020
 05:36:28 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: fix pp_clk_voltage handling
Thread-Topic: [PATCH] drm/amdgpu: fix pp_clk_voltage handling
Thread-Index: AQHWL3pwKaXHXOoM8karPVnAtljnpaizluEQ
Date: Fri, 22 May 2020 05:36:28 +0000
Message-ID: <DM6PR12MB26193E422D265ED79D98C7E8E4B40@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20200521141507.1042075-1-alexander.deucher@amd.com>
In-Reply-To: <20200521141507.1042075-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=c9a932df-4c2b-47c0-8836-0000a8005a84;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-05-22T05:36:20Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 29501e5e-d08f-4632-2965-08d7fe121353
x-ms-traffictypediagnostic: DM6PR12MB3498:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB34988FEAF9AF93B1A85691B9E4B40@DM6PR12MB3498.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:213;
x-forefront-prvs: 04111BAC64
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rFgB+enQg63+fHr9sCqXCR5tx5MrLm5RRyLPwv6LjxXHHB7GaLc00LRQFvufroWArWfYl493rgoCbAl7aGdjvTh8LJEFXSvSUhzTbuApPTavP7U1CiyE9JEZ/IH96Vr/P+xMvk4kvMnjcZ+mMg9MBNK+xBjoyOqZp3kPc0H3P6aBKp439CnWfGqJudZXZMVG3pg3205LmtZ9ONbncLV0fUdA0W98lIloHG/n6vU4U/nzbKXRTrhPDzQUKb+XHXyQhngAXgEHEbgf9n5i53QA9736qhf6FrIbjnMEO7+OW9rFG74MeUSG1/pZYUlJ9UqXjPmj5KV/a/IS+uJFqyNyqs0Zc1oOzS2ujaECefjkOGEHtcDKcymChDbdsflf1kUi41tEgAUhWAIf/q57Cbyv6q50K0gFsVGD095asaMQ398lzT98Q/ohHj1ulmE/ek6mVpflzlxjZxurmY9S7Z0wIPP+LLCy2YLm4DjWFIUSeQk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(366004)(396003)(136003)(346002)(376002)(7696005)(6506007)(4326008)(186003)(71200400001)(2906002)(33656002)(966005)(66556008)(66446008)(64756008)(66476007)(53546011)(52536014)(76116006)(66946007)(478600001)(26005)(316002)(8676002)(9686003)(45080400002)(8936002)(86362001)(55016002)(110136005)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: rXJ3TaC/by+8CB0vxuVel7BQvWUwJzzXWd81NDaB30MQiAoYh9K6IL6VyuiJlIZVeYZiSxvOJWL/XsbgldnJTB1iZRauYL4mE187i9OW/Zfnc19XGPslWrb70QFtZ8bG+EOgFoJFUJqnrwyTOAs/XkIuI9XcsgUPMjZRFnyneXBPvDSGv51e09zn/0yTqCoulmv71pbdF+n+VW0TbxWDTeLzOOlYQHbijTgrG1RAnOl4gI13sbsiw5tdqzD+cRCZoNR6Mv/flPhFt/jrVsYYOsYWlhIWMsMLbn+b9H6SEIIAx0AruXavyfI+WxmIwDyPC+/H1Mky3cMFTzdEbifEw269J4utTUy01j0iDsh3lIpQh+3vOYJXh+wpuqfyDL6SIHziCHlUFwKv44r435aZ6pCXEZS0YshRJNGq81febbwl9KzUZwf1sb6mOaZqB6xFtCLM8sykbQzwg3+Sg40n4Cz5klPeNFZ3U5shk63T6ZOEjVq+G3ekoWnEMo7ZzjUL
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29501e5e-d08f-4632-2965-08d7fe121353
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2020 05:36:28.1489 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kWBPqLaKZ/lnSCdHqjRAsTip+NENJRg0jAWSKa5O5nrR+omsiebnT+0pnITenXwd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3498
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Acked-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Thursday, May 21, 2020 10:15 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: fix pp_clk_voltage handling

Fix a typo with pp_clk_voltage that prevented it from showing up.

Fixes: 4e01847c38f7a5 ("drm/amdgpu: optimize amdgpu device attribute code")
Bug: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F1150&amp;data=02%7C01%7Cevan.quan%40amd.com%7Cf9ce40dd1bbe4648398508d7fd916496%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637256673966766036&amp;sdata=LDdO5lyk8CBtzTwIk6WPWvHFAnQFRByAyfPK4dyR9hU%3D&amp;reserved=0
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
index 2fc51f815eaa..88dfc61fa084 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
@@ -1746,7 +1746,7 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 attr->states = ATTR_STATE_UNSUPPORTED;
 if ((is_support_sw_smu(adev) && adev->smu.od_enabled) ||
     (!is_support_sw_smu(adev) && hwmgr->od_enabled))
-attr->states = ATTR_STATE_UNSUPPORTED;
+attr->states = ATTR_STATE_SUPPORTED;
 } else if (DEVICE_ATTR_IS(mem_busy_percent)) {
 if (adev->flags & AMD_IS_APU || asic_type == CHIP_VEGA10)
 attr->states = ATTR_STATE_UNSUPPORTED;
--
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cevan.quan%40amd.com%7Cf9ce40dd1bbe4648398508d7fd916496%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637256673966766036&amp;sdata=DGtoAsuqvILkQcxB6cqhtXXi54gmGgWDAlBf0Rr1ZsA%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
