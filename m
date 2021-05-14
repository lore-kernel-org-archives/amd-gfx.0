Return-Path: <SRS0=oeKV=KJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C72C433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 02:39:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F67061278
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 02:39:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F67061278
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2AC26E0DC;
	Fri, 14 May 2021 02:39:18 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E05A6E0DC
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 May 2021 02:39:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j7efyZQjy+fXKik5uJ0Rq2D/barqyjtD2TZg1NdP72yc/oqFOb74Z7K35gjSpQPW5Xu00NvIKvZhYi5laO51nEStfGxfQ4OQFPV3+ITa8PqEASSxexDPFGji1u3df035qOTLFwiq4UvlWkkfBrMGIe5pHKLBrArgC/EmJ4kjGKqrxNaezDUhAA1lyrTkOWbMDUTqWsWJgxm88qCvcCNgIcYQ4DakCxh7nplkRfNdOOoc8nCWxiQ/cWkqpR3tXYoWjqz76ybrql/3BLweZaThVkJkLqdmqb2Pfpc7uSY8UO8oWD5+apHIQIHALa5EOef6O1QGN7jkH+u90At+UPrMJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8/VbgYjZ+p8Ymy35nh14hrySE6roqQ685YbwoEVsGc=;
 b=Uo7sxAK1+Jmtd5D2eV1WPFg1KJxGS2T4GcaXwU8SwQtBw2SDg/Tkz61qUNJNF3PYYILwODB5fJyT5AbP9RpCs5bOlBAfVjLf+11pgZ3Xj+//Bq6iHZyjwYajWEf34jNmH6SeQDySxPJ0SKhgroIGhz9icnOnh2M1WfXTxGrmG5xwS/HcDpLPBsNavni+XxIAjFAkCCebW7VQS6awLPSPh3m5b/diWnWHT4B9dHyoy/hAIVs+riuu5IFPyq02ak7JYMbjKVCjpocoKpgA9b7t9Hqp+wIoBe50wAHBq36hSzjGunWW3H4HvRO2CaTAZP8MJ6DpxBLjVTwankhbHBuJ7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8/VbgYjZ+p8Ymy35nh14hrySE6roqQ685YbwoEVsGc=;
 b=nSe5pDHKXu0VHpVPsDIDiuSTaezUjqQFUwRbUYrHtM4YYif02pCW4DQnEqmYrHdbiCLyw2pj3FPDLZzGbagDl1VWglsQJ95OPzd2fqdo0ZC3y6IsGaZJDff014tJzcnDothb8wQj+GYhaMji5b5UdB2wd7LWhsi6zuDaad/C4GU=
Received: from CH0PR12MB5156.namprd12.prod.outlook.com (2603:10b6:610:bb::17)
 by CH0PR12MB5156.namprd12.prod.outlook.com (2603:10b6:610:bb::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Fri, 14 May
 2021 02:39:16 +0000
Received: from CH0PR12MB5156.namprd12.prod.outlook.com
 ([fe80::a1d1:38a:2086:b5b]) by CH0PR12MB5156.namprd12.prod.outlook.com
 ([fe80::a1d1:38a:2086:b5b%3]) with mapi id 15.20.4129.025; Fri, 14 May 2021
 02:39:16 +0000
From: "Gu, JiaWei (Will)" <JiaWei.Gu@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Nieto,
 David M" <David.Nieto@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fill adev->unique_id with data from PF2VF msg
Thread-Topic: [PATCH] drm/amdgpu: Fill adev->unique_id with data from PF2VF msg
Thread-Index: AQHXR8L16W5YG33TlkyouVsmvlLg0arhPsmwgAEGMWA=
Date: Fri, 14 May 2021 02:39:16 +0000
Message-ID: <CH0PR12MB515669BD1D8D0402206D641BF8509@CH0PR12MB5156.namprd12.prod.outlook.com>
References: <20210513064051.12930-1-Jiawei.Gu@amd.com>
 <CH0PR12MB51566C4310A9E3644BCAA9E0F8519@CH0PR12MB5156.namprd12.prod.outlook.com>
In-Reply-To: <CH0PR12MB51566C4310A9E3644BCAA9E0F8519@CH0PR12MB5156.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-05-14T02:39:09Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=65b63341-80d1-48f0-ba53-eb2bfcd9aa77;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f29705f5-4905-4fcc-61d1-08d9168177bc
x-ms-traffictypediagnostic: CH0PR12MB5156:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH0PR12MB5156759EEDE051D6C7CF59B3F8509@CH0PR12MB5156.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:341;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bvuaCKaenPc8nrFQrxfmUeEZQmmNfE+woD2KyMDVuEd0fHlKwA1HCfcYcCY1RL9YJqLj+qPrvqSC/mlXEFxlauMC6HdUoIFdJbmuf42B+Dfd7e8fh1jPbsRQZPhpAMLMN1+7a+lOkt7Sjzi+chiEyDY/dK3N96SIIEwPVfAS0xOqQCBJdR6/X/q8X8ltt01+qLaF6WLkrvb6PYY1dC//isj9kE1ZoE7/Co81BwYyEW+xieS8ZfjCNAmSRTnbMOYEbAiWD4XjVhSobWUUfOYDYv6rK9vtD2bJarWYXJOcOiOCw4cVAGiT7mtCUu3RwmY8q4Uy6Cx4OyCxc3e25VRApgsUMm2KdU88ULWnL0PYEkeMFGOyT/EH8RJWDrGx6huigJLZ3FEWnuEYgC/uzE/IyHYTHDSQnp/CAzkfJHVl2WauXmfE2QDwXDD/Uc3nfV3r74C+s0X2iHuxBMbA3xVMNCzMW0q6n0VMqlY7t5U/9RGaKh5Jkn8phsBmPRlMGOCFesThzvbmTHMCimvQn7FveydrdnBPZX4zRo0RLQfDpUdPgpDbuzfo50BwVh6/yq20CJdkCPf4Jp7+EZsLqNcazfFvu3ggRdF8tUl2BKtFIb8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5156.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(136003)(346002)(376002)(39860400002)(66446008)(7696005)(66556008)(66946007)(66476007)(64756008)(186003)(122000001)(2906002)(110136005)(6636002)(9686003)(316002)(33656002)(8676002)(76116006)(5660300002)(55016002)(38100700002)(478600001)(71200400001)(53546011)(86362001)(52536014)(4326008)(83380400001)(26005)(6506007)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?VxBa//xdUSQ8h1VVWmz27kcBGwczyTCmgUlZZUyBayijmPBH1VTbmfvwG8Ie?=
 =?us-ascii?Q?T5pZpvsIBOH4Yk60RHEHWBO5lMsiCBlfXgVGAElP7cI4Ketci9oo0vhfdivd?=
 =?us-ascii?Q?50G1QQ0S275aX54a7nzeoMnCx6ST1FN7I3QBOILWdtOG3IZ40pysqEZ+ACGn?=
 =?us-ascii?Q?T74g9e+IaWyYxsPDQhgHGhudr3r/pECEfwu+CKSmGwVfH5my/Yg3ZwmNkmS0?=
 =?us-ascii?Q?SrKZYvWNE7cEH1qYFzDOzeeq1m1pbYDnhxKAdnk9AEkw4oJVlMM3ICdSlQdV?=
 =?us-ascii?Q?LOu9cABJK0QEF91OnrPVMy83FpGGkkUjC2320RUm/EL/oqoQsAvfyUss8AJj?=
 =?us-ascii?Q?J6IExoBamJqlPLjTk0UU3SfXZkpqPDZWl8CZaicovj0N/yaUONLLGpqATL9v?=
 =?us-ascii?Q?x8KdU7nvavR0DVpSPQbmbv4WYwLnUYHJ54nSrRCLt8kdSoOGG3FxS75oOBY4?=
 =?us-ascii?Q?6SqWmSUAYsZOrXJD9aMxix+GWbhxA5vK5Bb7cW/gGO+6rRm0Doxqnj/jCoaD?=
 =?us-ascii?Q?PzYPnvjxlvZmCYqA6W4ITgDKpMkMfBWAyVx8N36uFf+7UXaJfDV5skqlOd4q?=
 =?us-ascii?Q?4fVeFA1PtTduJGQevOduCP+WLwMRurMwnmDCRSCMGf8KFfql4eFbZk1dfaDl?=
 =?us-ascii?Q?hmm4JU9H9xH+pR03+jITjB47CbvPeY1EBoF0qtt7LW6UHwmQCCfujOBLIXmz?=
 =?us-ascii?Q?YhjSLPml29r6gxbM7uAo9DDyxTNMkc36BYKaJlJ3sjFx3bsaf72i+aiy0eLE?=
 =?us-ascii?Q?yPbpz6jPBUdRqVyQdZnA5sWdWyBMV3Jycm1LuVorCA8v8kuTRZ4YrgL03egg?=
 =?us-ascii?Q?e9XKz7H4NEPCe1Va2XJ1lXcn/XlkKdkx5ZEXWDtciMgGc2h3y4t4PLusJTTh?=
 =?us-ascii?Q?gsIco+6hVlF1Nawc3i5JFl8vPGAfeKILGTHXu3hmgjFe9XY25UQe1CoLZX0I?=
 =?us-ascii?Q?r4cKFliczcRJS/D//dcFL2+RVPm3PNV5cJULKaUYzm5FvJCAi7NLzlwSPyNg?=
 =?us-ascii?Q?zjS1+OyQ+QYvkl+5yXJ2a0p4sYIxWELatLBuiSRvdDlpqpOrddLIs3GLHeNa?=
 =?us-ascii?Q?fXZMtMPnMCxCypErD5EJkFjU/ETHNEiiUit07p/nUno84Qoc5djpxcm+Hjbz?=
 =?us-ascii?Q?vZuwGlVSNzVjlV4rHFbF2hoKpCJP3VJo1X21xV1Dk/1BSJmJcNVNRwK8q4t9?=
 =?us-ascii?Q?k4hQU67xniHEoiLzbpwpeZYAk9LGs+C2Jg5TR2KKn/7azzyNQflaLJkX841R?=
 =?us-ascii?Q?yhnzCyphBO/BAImftPLhFK9A6KtY3pHA/BMWiJysC82wVRWuMNmdNh6c7d1Z?=
 =?us-ascii?Q?hTkS7EShQzQBxfNyuiEF/6mi?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5156.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f29705f5-4905-4fcc-61d1-08d9168177bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2021 02:39:16.2603 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fLo7ihlVHU3/LbjLvO6rDgkyBggtxgkVOC/w/lZC714oqi7C+/+W+JG+ThO1f3laG/F66Bc9mr5bn+KIGo4x/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5156
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
Cc: "Deng, Emily" <Emily.Deng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

pinging

-----Original Message-----
From: Gu, JiaWei (Will) 
Sent: Thursday, May 13, 2021 7:01 PM
To: Jiawei Gu <Jiawei.Gu@amd.com>; amd-gfx@lists.freedesktop.org; Nieto, David M <David.Nieto@amd.com>
Cc: Deng, Emily <Emily.Deng@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fill adev->unique_id with data from PF2VF msg

[AMD Official Use Only - Internal Distribution Only]

Add David.

-----Original Message-----
From: Jiawei Gu <Jiawei.Gu@amd.com> 
Sent: Thursday, May 13, 2021 2:41 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deng, Emily <Emily.Deng@amd.com>; Gu, JiaWei (Will) <JiaWei.Gu@amd.com>
Subject: [PATCH] drm/amdgpu: Fill adev->unique_id with data from PF2VF msg

Initialize unique_id from PF2VF under virtualization.

Signed-off-by: Jiawei Gu <Jiawei.Gu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index a57842689d42..96e269cbe326 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -471,6 +471,8 @@ static int amdgpu_virt_read_pf2vf_data(struct amdgpu_device *adev)
 			((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->feature_flags.all;
 		adev->virt.reg_access =
 			((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->reg_access_flags.all;
+		adev->unique_id =
+			((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->uuid;
 
 		break;
 	default:
-- 
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
