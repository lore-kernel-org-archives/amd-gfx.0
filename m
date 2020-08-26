Return-Path: <SRS0=g3tc=CE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F1AC433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2020 03:34:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42BC020715
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2020 03:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="IGlfmeHh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42BC020715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A860E6E9F0;
	Wed, 26 Aug 2020 03:34:02 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB16B6E9F0
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2020 03:34:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IrJ3330JR4b+2XUZOTZ38gv8S+tHZ9fzPsTFtjwqdeUCzDpPoJDRoad34jbG3NLZql4F2CZzYMGQwnJ4crQcp5dZ003k7I61MhhzMUEOz2IJpdEWkOOSqcZ6fBAoKa32+h32jRpgHhEQzrrBYoZMs/HqSDLqy3ciVZ4q7nH1VE+Buv91JGQWHaq07unbgLEwIMEoQSlgb+bdDHUouRrJHQYu/sS2I5Pm6tuFKrNG0RRdacmTCiqoq7JTefBVJm7GFgm/GXGQSQHLpvVl++lTnr9E/hrvQYJtM+ZMwSqegrhheoFlv2D/MU//U6qxCktvmuQnxZyOok6LF+tFSVaelA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g11EYyirpQgECy4AKDNgeDrrYNezfpuUMpWRpXutxxw=;
 b=MjOMeHCnAJR+EmQGg13nJQS/VJkCrr0CuqnCTWFUpn3OLTnh92T0tAWHRer/J4pn/Fgc33J92IQHGPE1TOHaeILma+2QOahLE/weSVLX0bkmlSQe2BhoiCzUWkug/skXrlvO3+clhqIW+IQYXw4rKSIjlv1/1MP28ntrtY8rK/y4WB/sPIeq96lU4hyREtAYEGmJvIjfRKfdHHg1PJMWcwDGZATfgzDTBMgOfy8wg7hU8QoKpzKZbtp9QviDt/DE8mudGr1tOien3tTSMZ9dWWXzRR6gEW/7VAjEa6f633UBqliD7a9ecGUJSrHauKmgZ5iBGbBiJfHbpe298VPtsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g11EYyirpQgECy4AKDNgeDrrYNezfpuUMpWRpXutxxw=;
 b=IGlfmeHhbMC1mKT+RKUEtc36VyeZQpHeZ+uL3T5fY/yOoHlEABVbYTJ+cZq/7Ey+7p9rC74E083xES0gznfm48tmjqmtDxP7CU4wqWtt0T9Ge+Ivn+AOY0o5LabUZfx66E+2zRnxvqFSysQzdhH0gKBlJ3Om/fBxUtAcNEavSVk=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4058.namprd12.prod.outlook.com (2603:10b6:5:21d::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.26; Wed, 26 Aug 2020 03:33:56 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3305.026; Wed, 26 Aug 2020
 03:33:56 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Dan Carpenter <dan.carpenter@oracle.com>, "Rex.Zhu@amd.com"
 <Rex.Zhu@amd.com>
Subject: RE: [bug report] drm/amd/powerplay: add point check to avoid NULL
 point hang.
Thread-Topic: [bug report] drm/amd/powerplay: add point check to avoid NULL
 point hang.
Thread-Index: AQHWesny9bCT8ky2Pk+f5Qze8Mg6SalJva1A
Date: Wed, 26 Aug 2020 03:33:56 +0000
Message-ID: <DM6PR12MB2619E802317BF51236AFE624E4540@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20200825102425.GA272450@mwanda>
In-Reply-To: <20200825102425.GA272450@mwanda>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=1af626a6-6d59-44b5-98d1-b354995bc61f;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-08-26T03:33:14Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0a07e35c-3153-4087-81c7-08d84970dcdd
x-ms-traffictypediagnostic: DM6PR12MB4058:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB40585220E9653EF4BF355351E4540@DM6PR12MB4058.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oW8cxh5ImKzCGG6Mn3YQWTNx842cMf8z8sH6G7euAmX3+aQGPTO/u+Mp/aQi5GtAMY1ZBiam/YhBAPRMbpGQzbB2hT75pWQOoLHuuEJo2FTo1KgquccW7xfkx6mzHebdKzK25z3n37I+pTuobgVNzfNJvWya9rSOrO7362ta0EAWe5b/6+HVkJSRsRSh/KRafgl5WETwrB2qPyLTplnQ2i9r7ZaW+1fy8q360YNK7Bfz8QPV9w93gZzObM1TL+pFqiwVqIDYMevEZSJqqu4MB2DzbTq+9NBV09rkAUwes3b9o4IeQeYVtna11TA/DM432VV/vAKyGjJxtlpa76X2J5hPfiXHDQL0thGLXyzPg/4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(136003)(366004)(346002)(376002)(45080400002)(66446008)(4326008)(53546011)(6506007)(71200400001)(33656002)(5660300002)(6636002)(26005)(186003)(83380400001)(2906002)(8676002)(966005)(316002)(478600001)(55016002)(110136005)(9686003)(8936002)(7696005)(66946007)(66476007)(66556008)(64756008)(76116006)(52536014)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: e3kvRpB2j9VC73Eq4mwHiN/Db6rRGfTbp7DDwZE8B/HlYBPpMATTXRCf1k2Y504M5ld6z6s7cGOEcMwE0cW6i0oRgZMY51x22FljOEA6+v58kCKKRfxq7Pj74T7lZLmGRN9bSaSNH1Vn2cByr5BRQDWgKUt/6ZudNoFyy4jq6FV+m+Uw8PzjrMUBMrn8FKjRFzPbl3gTes/dHRNIlaHxMsiXGXcLmMyEcY2XQA2t+NMM5i/18BmlQ1BOYbA+X+PR2+BNo+OtAyCNzTFYtt6EpfUlAl3Tjeq26DacNmiv3NwtusIPBIL16AE2CwuxsCj7bTreO5IHPTKRsiqcW0aSoGrsRuKC0/rUs9bjdYngQr2uLP59ZKTaerUEfR1f2up6DS/gBq0xOwd/cuzwRZB4wAgYM4IX61ucFqQAsaxW4OmVj9lCDtjc6vuPqxQ0+dJoNMzIRGHQzFrAAVOswXajoQhgGyNDjWyIFRh4tebqJEl3h98JIhB9lD04PeHWwSYSJXho/H4GFaLpOaTzMCRPUZ5j3MoRP5IzAaAnOjVXdeW6uh6AYOixX1EnyVjVIRsbEKNkOWVeca2FnumhAziRsJOLEpwyme1wu33W7URQvHmOLkq1nTR3s2gSTqHo0CdJ5I5Ex2mduIItT7weK3vVAQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a07e35c-3153-4087-81c7-08d84970dcdd
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2020 03:33:56.2055 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j7/KTO2fQYR6v2OyuPGeBpz2xjcXhyrNHwUmDmFyuIQeSFI7laZKtvTrFpC4v8pz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4058
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Thanks. I just sent out a patch to address this.

BR
Evan
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Dan Carpenter
Sent: Tuesday, August 25, 2020 6:24 PM
To: Rex.Zhu@amd.com
Cc: amd-gfx@lists.freedesktop.org
Subject: [bug report] drm/amd/powerplay: add point check to avoid NULL point hang.

Hello Rex Zhu,

The patch 88b8dcbe21fd: "drm/amd/powerplay: add point check to avoid NULL point hang." from Dec 11, 2015, leads to the following static checker warning:

drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/hardwaremanager.c:274 phm_check_smc_update_required_for_display_configuration()
warn: signedness bug returning '(-22)'

drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/hardwaremanager.c
   272  bool phm_check_smc_update_required_for_display_configuration(struct pp_hwmgr *hwmgr)
   273  {
   274          PHM_FUNC_CHECK(hwmgr);

PHM_FUNC_CHECK() has a hiddren -EINVAL return that becomes true when casted to bool.

   275          if (hwmgr->pp_one_vf)
   276                  return false;
   277
   278          if (hwmgr->hwmgr_func->check_smc_update_required_for_display_configuration == NULL)
   279                  return false;
   280
   281          return hwmgr->hwmgr_func->check_smc_update_required_for_display_configuration(hwmgr);
   282  }

regards,
dan carpenter
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cevan.quan%40amd.com%7Cd3cadb4b92e04c5d4eae08d848e111a0%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637339478834526298&amp;sdata=236vygLQdbMVXk6XBDaayrTw2qODhcmTCFvtl0%2B95IM%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
