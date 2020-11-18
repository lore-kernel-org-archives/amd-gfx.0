Return-Path: <SRS0=Rejl=EY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2831C5519F
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2020 02:23:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12DCD24655
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2020 02:23:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="iYUEVdP/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12DCD24655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 528166E223;
	Wed, 18 Nov 2020 02:23:42 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4FAB6E223
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2020 02:23:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IIlXRI2xRlMIhhWe45mrhhzKN7PJLZE4xqay+j7AkzORT1l1MFcK6t5jWOfi7NR3EY6qYiD3m2oJQQtht6bk6y1vJNa8fvPZQ7aRT6MUVvvedO4uiAJ3iil9AagB3c8RpIpDtOOh8MOFcM4MnhjDh1RcO/BfhAGtH6MXskEHovMEUiuGkfJXPMDiObjI6fX6jiTifZ653DiQJsbZhUUylt/VUAF5jXyiPt/1b+jd9oTg0Dt9EAbgXzFh0ST59buJs3F6CntXBb4NJm0vgU6iY6TJt105o5qfdQCtJu5Fj8YrLKcJOC3FCfkbJMosAFuwFPoOPP/ephbG4bvP51CsXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E4qpuq0HcVoHUHCtmZ0cz3tgBGQlb9//pKKjFXm29ko=;
 b=CNaLvJMzk6X1OAJ0NCl9caaHQdCYo1a3rhUXw2fh4+BLFO6U+JE1fcyKGqaDUt6tZ+cujS/JaHN2scY7BHgy9nc1WnxeJH+KST557Cw7kiphaOwLRqZqUgqEyLjWzgpe4ScFpdRXYtD7g7dS4PaWBXcsPW/LCq0MlgUrHBWxhN0Il+vqGx5ZfQMMjrcNRy3mavA31xgV54SBw7YbOwrKtNczu2GfxX4L9lcfsXVHBDB10ys3wEHUGjXfHSs5I7DsQRWDZzMJIk4fh48YuO9oJ0xybJj68A33l7GXIxkLZDjcvA7S/3a0Nb3R6HWQ5JgxEItuP+BRiTRm/0QGZYnZwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E4qpuq0HcVoHUHCtmZ0cz3tgBGQlb9//pKKjFXm29ko=;
 b=iYUEVdP/NbJZiLf7tVJapwnU8AMzs5pU8YeF6IhTOwP0kJXBILkX2HJQoCLwA6QfT3rQg6a22xLxFU3k2P+ttMnXZe/fURXXLagVf8AI/9XeujG0UQQVdPO6CsOedx6CKr0ETbwhJT38MjwOrXSQS1YwXv2bkK+AzOKTpYwu4/E=
Received: from BYAPR12MB3640.namprd12.prod.outlook.com (2603:10b6:a03:aa::12)
 by BY5PR12MB4804.namprd12.prod.outlook.com (2603:10b6:a03:1b6::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Wed, 18 Nov
 2020 02:23:38 +0000
Received: from BYAPR12MB3640.namprd12.prod.outlook.com
 ([fe80::419c:3a8e:3cfa:fdfa]) by BYAPR12MB3640.namprd12.prod.outlook.com
 ([fe80::419c:3a8e:3cfa:fdfa%4]) with mapi id 15.20.3541.028; Wed, 18 Nov 2020
 02:23:38 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amd/pm: fix the crash after runtime pm resume
Thread-Topic: [PATCH 2/2] drm/amd/pm: fix the crash after runtime pm resume
Thread-Index: AQHWvOXsrglJUTKeYUqZDrGYRFBRJ6nNDogAgAASb8A=
Date: Wed, 18 Nov 2020 02:23:38 +0000
Message-ID: <BYAPR12MB364094BB5556E37329775CC78EE10@BYAPR12MB3640.namprd12.prod.outlook.com>
References: <20201117133051.1016-1-kenneth.feng@amd.com>
 <20201117133051.1016-3-kenneth.feng@amd.com>
 <DM6PR12MB2619E8B1298EB83E9BAF707AE4E10@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB2619E8B1298EB83E9BAF707AE4E10@DM6PR12MB2619.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=7e398aa6-0036-4b40-afa5-c36b6b6c3f6d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-11-18T00:40:58Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-11-18T02:23:32Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 6666cd5d-c598-4eb6-9cc8-000066d42264
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b00e710e-54a5-4431-5782-08d88b68f55d
x-ms-traffictypediagnostic: BY5PR12MB4804:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB48045B05C99A99DC6356437A8EE10@BY5PR12MB4804.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5CDvjBjLuN3pj0sZIlXwHGT5ujU+LgOGCoadvDxNQWzez4AUFiLDxnqMvalxluCVidSiqh7CV7yUzmuEcFY66HtzlG24yHnjzhBsF0gE2u3u4/sk8yvbmElGutER47HHmfNGS57oDHGYf3lrztRMwvm7wUoJJ054aGUxfDTQfx33RUx+lz6YzcbKf+hIEw/UAzfHdKEc2B9T6ISOXmdrnMi6eK65qEODeAl9h4HK+eZMp0zaCAoM55LGvscqZwrJj7w5rRW0E3aAj2SVj9eYSbwEFczKIU4tgr+PSPeKrAqr0/pJEQPcbVzeOkNP0f7rozAhmXrjhQuOEK2PHfw5ee+1jQwqdnSphxIKGJnGZZM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3640.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(396003)(376002)(39860400002)(136003)(53546011)(8676002)(2906002)(478600001)(7696005)(26005)(52536014)(66446008)(66556008)(66476007)(64756008)(76116006)(66946007)(5660300002)(86362001)(9686003)(6506007)(71200400001)(316002)(45080400002)(966005)(55016002)(110136005)(186003)(83380400001)(33656002)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: ITdx9+DZQ0evHFSOGrdNrav00ppzcZsRy2NNqbfZR2DukfuBAHHgNtdb3kJV6XX/ZpRA5zawh759Z5oPHxVWNTA56KiTMnY2TzfXI1FecpUzETrOOL4uuQXcn6B77UQYJFISFYBrYwH921soE50OJKFOn2VPuyACScSYBvo4f117ff8WV15BHIIZao+/d6rHstm3ikwxb8iuv+hL7ku5E/SKHcfwkjHhDZWpmM7fK/g6GO1FiSw5HNGnSxYqlwOqXQNtw/nffnmTd48p2Ix8OgHSGU2PO4FlmIXooWQr2chwtLGDH+Lht2s9wF4c2GfFfDaDVtFwMYDvtvmvy2bllINHOf/CG0zSL8Mv2EE20emUNqGdykbcKg5AoddfO1ddvfaUkxFnoBK6gWxo03uAtPy2asOrjOHe4LGWVHmNy07JpfRoLlZo11xIsM8+gf/yNUq+iAaKI+qZv6v+68dKJGGffmKqeNG2DuJ2Buxi8UhOZcDe8geQeIEsWg4UHdGiE2M8NAHyFMMTOd5Z3P0DGTcd9AJkG17BTD+cKbzlU8M7KdGSx+l/eAds0nzxVsAQAYHVQBMyArY/sqa3viEglcvVbuTZz5iCzGkGMwFMAGYnEOqNn4zIktus4eprVh5S5cmGcVo+XyAAyLyfBLpFPsEVtXo4SpeJvEnEoLl5fsnRWqJ27U/Fh15zzfZznVKQ2ujody3IMOZAoIw/j2/CfBmj9wh1MLnhiICJ18RV+fnhU6IrhWiDf+vc5yiWL3yJcie8LgWflJmuRjn1/dWtb9QJlastT1ra5cBNsWFP2hBYwog+3q7qlXb8ehD5NMCPpYr+NmkNFTT6ALMqL2knGkxoUGwb2ylgJm4tRhlbUuJOLcUm25g2LhfY/V7spYBrjYzJo9y2x0nxulvj1vHsVw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3640.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b00e710e-54a5-4431-5782-08d88b68f55d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2020 02:23:38.0860 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dn6W5OvwwwkE2RWtp6vkSoseDqNsge2YB9+ANFwta+1iMknnl6Es2j/iIcDQZWFl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4804
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

[AMD Official Use Only - Internal Distribution Only]

[AMD Official Use Only - Internal Distribution Only]

Hi Evan/Alex,
In the process of baco enter/exit, smu disables all features, so smu_disable_dpms is not needed.
And the sequential steps in smu_smc_hw_setup after function smu_is_dpm_running are not needed since baco doesn't clean up the smu status.
This fix is specific to SIENNA_CICHLID. For the other ASICS, need to confirm since the firmware might be different.
Thanks.


Best Regards
Kenneth

-----Original Message-----
From: Quan, Evan <Evan.Quan@amd.com>
Sent: Wednesday, November 18, 2020 8:46 AM
To: Feng, Kenneth <Kenneth.Feng@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: RE: [PATCH 2/2] drm/amd/pm: fix the crash after runtime pm resume

[AMD Official Use Only - Internal Distribution Only]

I suspect "smu_is_dpm_running" reports a wrong result due to "smu_system_features_control(smu, false)" was skipped for SIENNA_CICHLID in smu_disable_dpms().
That is outdated cached values were used for "smu_is_dpm_running".
If that's true, a fix in smu_disable_dpms() may be more proper.

Evan
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Kenneth Feng
Sent: Tuesday, November 17, 2020 9:31 PM
To: amd-gfx@lists.freedesktop.org
Cc: Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH 2/2] drm/amd/pm: fix the crash after runtime pm resume

Some features are still disabled after runtime pm resume. This can take the hardware back.
Unlike other projects, this doesn't need pptable retransfer.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 39990790ed67..ebd50f144c5d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -914,11 +914,14 @@ static int smu_smc_hw_setup(struct smu_context *smu)  {  struct amdgpu_device *adev = smu->adev;  uint32_t pcie_gen = 0, pcie_width = 0; -int ret;
+int ret = 0;

 if (adev->in_suspend && smu_is_dpm_running(smu)) {  dev_info(adev->dev, "dpm has been enabled\n"); -return 0;
+/* this is needed specifically */
+if (adev->asic_type == CHIP_SIENNA_CICHLID) ret =
+smu_system_features_control(smu, true); return ret;
 }

 ret = smu_init_display_count(smu, 0);
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cevan.quan%40amd.com%7Cdd553fd04f0f44ebf3ca08d88afd11ad%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637412166811942772%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=SgtA0lq6Sx5aiQ5PSLvf9GdXUU50cFLE5ELMY0e8k5g%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
