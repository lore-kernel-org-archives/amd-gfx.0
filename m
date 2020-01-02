Return-Path: <SRS0=MtTs=2X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD62C2D0DC
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jan 2020 13:54:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6F0D215A4
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jan 2020 13:54:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="jUCjXMMV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6F0D215A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9747A6E0F0;
	Thu,  2 Jan 2020 13:54:46 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680067.outbound.protection.outlook.com [40.107.68.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F37246E0F0
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jan 2020 13:54:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GPHLiBYfMB+Y5EBCYxGBxuidbvkFwf4pFoN8DNjK5/bqINlZxbYun1mYFLMenY2e3+q82/3c/xzZVRtK8k7fGC/dUiE6SCWVSd2AxVSiJhhpo2a3BIhnmUPKFX9cU5RtXNs4yTtHCjglBNJLq4W2J7FmAgl9o/g8Ya1lFSedeu1J52PcO2vltZXkKBuWyIA5I4rJiKbXyYdcn8c7clpjK/YxyPmNWmlykKAYl1k9EQbRiUyUBrrVqK9wOgMSr9IrUIds8PjPzSggGW3StQsTNRRV5+rliZNbbDDCdifTxHZ5Erdab2swapkSlGvFolOW74f8OyetNAMw/OoTEtus8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zwEJDDUGUErZHetTyTPL05FQmnSJZqpx81cNw437K/0=;
 b=JZF18JH37ewmpnoPiSoRC97WobqrmdywDkcmGvNNxLV3NsrIYbE1e02wVI3XpZ5GIaCJZ8DpgZDF7KKh0b9jYOgSXZq720WM8bwdWp41jA4PrFXJeUMsu6xUaCrb99EYvlr82/rXpTcExWprfapkE/+XyvGzKDtUofssDq1l5oJhf/hoAoBoETkU6Uu0D2HBO9ru3XI9B/nGRXwvDXZMnlMjsZTNBTSHq9Scn+TIjLAOMTB6DcZVi+Gy9sJyCK9ZteRlIr3RzsSfjHcuwtgLepPwDJK4f0xhHNz1wMpuQbNpJe44S9ThAEMy6qngUk1pIRvRcw4WG21lhDCYMEcMBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zwEJDDUGUErZHetTyTPL05FQmnSJZqpx81cNw437K/0=;
 b=jUCjXMMVb2lQFhRbAINDbHEYOR/gHc1LDq9TdINE1hqHFSkTuERu+AEGyg3saHZUSYCP1uijVqtUiqe4dwFse6DLxMGQg6agru/TBVaXJhh//xTT4lYaRLHaPYdGzcqy4TXBtBaeNmOt2+kkHeZSH3sep2lzQhFMKOGkkY8g6sA=
Received: from DM6PR12MB3146.namprd12.prod.outlook.com (20.178.30.205) by
 DM6PR12MB2652.namprd12.prod.outlook.com (20.176.118.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.11; Thu, 2 Jan 2020 13:39:03 +0000
Received: from DM6PR12MB3146.namprd12.prod.outlook.com
 ([fe80::d50e:6a6e:19c3:4c03]) by DM6PR12MB3146.namprd12.prod.outlook.com
 ([fe80::d50e:6a6e:19c3:4c03%7]) with mapi id 15.20.2602.012; Thu, 2 Jan 2020
 13:39:03 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/4] drm/amdkfd: Fix permissions of hang_hws
Thread-Topic: [PATCH 1/4] drm/amdkfd: Fix permissions of hang_hws
Thread-Index: AQHVtw/DL0Yl0GqNw0SjKiKQlJhpoqfXdVog
Date: Thu, 2 Jan 2020 13:39:03 +0000
Message-ID: <DM6PR12MB3146C09F3A5CF6E48C5BD8F685200@DM6PR12MB3146.namprd12.prod.outlook.com>
References: <20191220083001.30607-1-Felix.Kuehling@amd.com>
In-Reply-To: <20191220083001.30607-1-Felix.Kuehling@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-01-02T13:39:01Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=8cdefd5a-c282-4bbf-9ade-0000b0c56887;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-01-02T13:39:01Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 25ecf248-40be-4d60-9707-00008ed18875
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Kent.Russell@amd.com; 
x-originating-ip: [165.204.54.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8af506d8-2f86-44af-f060-08d78f8921cf
x-ms-traffictypediagnostic: DM6PR12MB2652:|DM6PR12MB2652:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB265207DA26B53D226D5B809585200@DM6PR12MB2652.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:765;
x-forefront-prvs: 0270ED2845
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(376002)(396003)(366004)(346002)(199004)(189003)(13464003)(5660300002)(8676002)(86362001)(81166006)(2906002)(52536014)(8936002)(26005)(7696005)(81156014)(33656002)(53546011)(9686003)(316002)(186003)(110136005)(6506007)(966005)(66946007)(478600001)(71200400001)(76116006)(66446008)(66556008)(64756008)(66476007)(55016002)(45080400002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2652;
 H:DM6PR12MB3146.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 72kjaOtJJmO0VU3oUBLk8w6BXnmjYE/tO1Os9qeQqZz0nzRY5cmJb8gSWEPlx4cO/9W3q3rPZnsFFEWWcZM0WRDYCDdxeop35m5nuiGSkJyAsdtPP2ptEsp5+9TS1GVokpSJvwZY4onR5f2381REtdI7Ej2egaELSSiVeFIKpxpyBZaJvvmujrM8Ncgh+YeL+b+HJpWyiZaQ1DNzXr3UaEWvDOkgKe+juGL2wFYrhibTIq7s6aWHoSkRN/X2e7Q+1CENjcYqio3iE8/0dEA2euZN9bCziNtC7pnZJVDU3cwreoGPQQ8vgzkpX+TzAiVpM2psVMD3cfHoZzyZtpWwTzMt0Dk2QwpOQmthpOY3hRcXAEBtyD3ThHihOZE0e4D68iLxB8fwF5j+3GhZEJIedoKnOR/uYmYDoUnTGU4Cm3JbRbrHM40ZiFULqxy04bP4DrYpZu/8hi3PtgAOydj0ZcVcfacebYBQimq3yl8d1n7Zwx083FNxb16D9j3udF/81+XKHodQhwNhB/GxIOnHPPb5bgFb3d73kUSQjHRZf+o=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8af506d8-2f86-44af-f060-08d78f8921cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2020 13:39:03.4692 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yI7TGY+p307LX78kIcExZAVYpP9yJqc0STsVXjXrYd4/O4Qzg4O/9/OhFjCtWuWRFNDkt03l7kHrcneJ7OqClg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2652
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

Reviewed-by: Kent Russell <kent.russell@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Felix Kuehling
Sent: Friday, December 20, 2019 3:30 AM
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/4] drm/amdkfd: Fix permissions of hang_hws

Reading from /sys/kernel/debug/kfd/hang_hws would cause a kernel oops because we didn't implement a read callback. Set the permission to write-only to prevent that.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c b/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
index 15c523027285..511712c2e382 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
@@ -93,7 +93,7 @@ void kfd_debugfs_init(void)
 			    kfd_debugfs_hqds_by_device, &kfd_debugfs_fops);
 	debugfs_create_file("rls", S_IFREG | 0444, debugfs_root,
 			    kfd_debugfs_rls_by_device, &kfd_debugfs_fops);
-	debugfs_create_file("hang_hws", S_IFREG | 0644, debugfs_root,
+	debugfs_create_file("hang_hws", S_IFREG | 0200, debugfs_root,
 			    NULL, &kfd_debugfs_hang_hws_fops);  }
 
--
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Ckent.russell%40amd.com%7C7dc16d27ccf646dd676608d78526df14%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637124274407198344&amp;sdata=joT5cPhL9glNqV85jTIqvygQ%2B6CSOprnadM8LzaRBQs%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
