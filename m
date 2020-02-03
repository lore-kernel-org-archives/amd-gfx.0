Return-Path: <SRS0=wWp/=3X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98ABFC3524A
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Feb 2020 03:18:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6397320721
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Feb 2020 03:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="4VjCf/xO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6397320721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC6B36E165;
	Mon,  3 Feb 2020 03:18:11 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760040.outbound.protection.outlook.com [40.107.76.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00FD56E165
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Feb 2020 03:18:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QsTtthKdnUmuPaSMj2Zg1TgOb76fjxvwMcETy3oLKaNETQkP2M9UU+n/t5b7KKZf0JAYaiBX+L+l0IJroCYdwZVPTNvnuTPH8yn8nUiUlmHrY65vz2D0AqAAQ+UyOZisRWQPZxflPasc2liyvwMkaDzafvWxQTDV3oypqbLDA1xcrxNYJ/OklTRtVtxCdODnlsUvhOnhM6owG5jAqp4cFWtUVfQfBYnlkPwx/O8WGqrumt/mIx1Wsz7doSfrmOtwXfivEznomD9X1DVncDOrO9YpNZdagcuNBRCddXVh7sz2M9TYFovxxMODA9ZkuocrpbNpfEXqPeN1jr5rte36dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YHU7RHzqtyB68chjXTG5O9XeG5A57fFhrzjI4XfN1pk=;
 b=lsSKGROZyJoUQ7o9IozIqCnBcUrYMVA9xjxBKVRzlVXp3WEoy0SJlhlh9wdM8L9VLA8YuFsWoMgRdry2CmXMxrAh13g1sg5xsdY31ZriPJyUS9rCDoDkUrTaFXKxlb+RVLb0KaFmcjmgB2DapseSVxz1PfKaOWGNItKYtnmstwL8aDkV7cwXE+FXJSIz1v3zdT5CrADItGAalypIZ05n9tJ0iQwio6uLej1FJH2kKMgLUnJVumIv4yKGSFgylhw7YP08evxWL2+N+YbIQBSZpfoStM9ShRVxZdfsuLXNMqHe0h90AbdEjY4uWUHOmX5SrpuOmqf3QBiIUHgfLsiiVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YHU7RHzqtyB68chjXTG5O9XeG5A57fFhrzjI4XfN1pk=;
 b=4VjCf/xOM0OtOcf9CD9nZP9kKTG3e7hY20Fjvd1EiN+OWWFz7Cm6VcxBjfXL5ugOjcf5iisOJ93SJiq6bKJHgQqSLi/43yElpm9EjYROxD4LRZ7Yb6f0dwrCycynVnHqYqWYSXkoMViidU+A0IQH5bNp/kuHN2JxFdnni9Hfc/A=
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB3712.namprd12.prod.outlook.com (10.255.236.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.26; Mon, 3 Feb 2020 03:18:07 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47%5]) with mapi id 15.20.2686.031; Mon, 3 Feb 2020
 03:18:07 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/3] drm/amdgpu/navi: fix index for OD MCLK
Thread-Topic: [PATCH 1/3] drm/amdgpu/navi: fix index for OD MCLK
Thread-Index: AQHV1tB01WhQqT1syUyVvetnSoS0lKgI001w
Date: Mon, 3 Feb 2020 03:18:07 +0000
Message-ID: <MN2PR12MB3344244DB3995FA7FFB86564E4000@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <20200129181752.609344-1-alexander.deucher@amd.com>
In-Reply-To: <20200129181752.609344-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=cff33711-3ece-45b9-8a4b-0000225317ea;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-02-03T03:17:29Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4594e3e8-6c23-480a-a368-08d7a857b0e0
x-ms-traffictypediagnostic: MN2PR12MB3712:|MN2PR12MB3712:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3712BB439E1F983695D1AA6AE4000@MN2PR12MB3712.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-forefront-prvs: 0302D4F392
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39850400004)(396003)(366004)(376002)(346002)(189003)(199004)(478600001)(6506007)(53546011)(966005)(8676002)(52536014)(8936002)(110136005)(45080400002)(26005)(5660300002)(55016002)(9686003)(33656002)(7696005)(86362001)(71200400001)(4326008)(2906002)(186003)(316002)(81166006)(76116006)(66946007)(66476007)(66446008)(64756008)(66556008)(81156014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3712;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZHsqEdHTxGInIeZTyfwrskGQSTNruuuDAMSmwF+0HSGCqZFIM/k8BsBPwoYdi3mqekz2FhphQiggKHsJva0fek8qvY4DeqZ19NjT0MRkV0ItTGXunAoV38lePWBHtzClQKlq31LBZQ8lHF5cjkntlzK9T4Nyq2uIIHkwCNdRAukV68K/2k/r4LJJa6YgUmxODGSlKWQkhMwOlafr7sdwbV31oS2ypl1kAiZ8YwIEQuY6iZ6cSbSnRSTjvqBUKXXtBdeui4yKL7tcaKm2Nm3dzGc+e48vg8xvkr6Jk2UIsL6RKzHbRZTf//T5QBGJkcO8uYnsIGexKfUQ8HjRLhfrFQZ+wxvT4dQnLwyYZlsSwIvAPFLV8HXMVq8JegRCuzN51fjRhJSa7mYTJ+4R0tLcy0OmOt16TPNMgJ3dAduol9GVr7qqJmjgHBvrsPDIbuVxXZ5mfOYjBLuheN22PkqBzpIfJZNZL9O6KREyiuxa0tAMPSA4tol8F62rlvzRBiSo5uIPgM/Ev+hAO65VonQDag==
x-ms-exchange-antispam-messagedata: wBCT+py++QNp5ZdGTsei/A9iI4D9PiGwKkTEKzX3uyn+JqjTJEIKmU2gtqYadPXVe8eofSr9LpXIc7L9XqXpuC3TqdaYjOhKrDTyK+b/ZL3S0rHGj/G/zLSWinl/lFWZhyRX2X5c8RsNzy6rcJv5UQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4594e3e8-6c23-480a-a368-08d7a857b0e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2020 03:18:07.6908 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bI5aVE2YiyNC8Qgu/2q54BpH6Ud2Bd/xaMXFyBh6gXsVUsw1Yz0WlhJxmceEB7SQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3712
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

Reviewed-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Thursday, January 30, 2020 2:18 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 1/3] drm/amdgpu/navi: fix index for OD MCLK

You can only adjust the max mclk, not the min.

Bug: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fdrm%2Famd%2Fissues%2F1020&amp;data=02%7C01%7Cevan.quan%40amd.com%7C7417fff1d6244791b42408d7a4e79457%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637159186863472587&amp;sdata=cGrX7IB6np9EmgZlDTJZYEmVaalq7zrh4CqBlUlSp8U%3D&amp;reserved=0
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index f1b27fc20c19..c8f09874c2ec 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -843,7 +843,7 @@ static int navi10_print_clk_levels(struct smu_context *smu,
 		if (!navi10_od_feature_is_supported(od_settings, SMU_11_0_ODFEATURE_UCLK_MAX))
 			break;
 		size += sprintf(buf + size, "OD_MCLK:\n");
-		size += sprintf(buf + size, "0: %uMHz\n", od_table->UclkFmax);
+		size += sprintf(buf + size, "1: %uMHz\n", od_table->UclkFmax);
 		break;
 	case SMU_OD_VDDC_CURVE:
 		if (!smu->od_enabled || !od_table || !od_settings)
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cevan.quan%40amd.com%7C7417fff1d6244791b42408d7a4e79457%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637159186863472587&amp;sdata=tpoWeKNdPMcF6hff7tWNxeLOJe%2Bo9KuPPoe3n8F5tXo%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
