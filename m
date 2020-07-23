Return-Path: <SRS0=nWm5=BC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3777FC433E4
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2020 05:19:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7BD420714
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2020 05:19:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ovCkJ5Jj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7BD420714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 699F76E0A6;
	Thu, 23 Jul 2020 05:19:09 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5E866E0A6
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2020 05:19:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dUXEAv5VHbZQVdUH9V4v26L90qKX82BEneJzpXL9NY6tYF/xlUOhFwkaamAOUu8G9DTYPAxh9xNDj9JkTVb7jO+3jcew5dsB3pZ4A4BcNvPb/HmMso1cD5SaaZXFpDD7wtVjQ4H4CSrUG0eudGH3Ua/yMzDV7Ingl/4HK7pYxvZ6CKHMDsaiqJKeXNGq3wCf+s7Svu2yEdE/nFapyfMUJAcT5NkQgYgoep0rLNfKEgKJW8AMSPsg9eUH9hTz0pDer2tFcUPAL63+kwX/T1LwmIcOKNAEWCIKAY+3Dh4ocUuYfnR0xU6WNDNrfK481eFGdaUvOwJYCGfjQcL+nCswSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QVh6j6iw199Uv0cj5LVfrvZQwt0EwMhoZ5OkTf7O9CM=;
 b=dDigXlTWFHuh/MF5bKETue7rp6KDDiRPGQbORBBsKS1Rrtk1J1sMn1gB7sJXkZdcG5diTkWB/1DPNO2DidsANtVcMmOQKCglTl9Hoq5bSKfXlj0vYXz6MwP0L1nrf+eFMoIOSy5dF2oV9zBErYyO1J2Jdrjqdj7xN5D/pGaL5eK+dTMK+QDXjLpwmFEOawEo+S7Pplp0JM6JYl3VnjUvKmsm2B9nxdK6qw1SMMrbie2k4Uf4DdJgxSUThjZuPL8pwPF8qUUbelhazQKNPmDvyZ/lIG1sVGkiELB+B+0l1jPpp+UFiy82ssgazEqJnc9E0QidIGySJiuUMPlOdPzD/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QVh6j6iw199Uv0cj5LVfrvZQwt0EwMhoZ5OkTf7O9CM=;
 b=ovCkJ5JjthZQNAFlN0L6FnF1ywe0riOCsB2dt0mg8MM6MkQ/1h0K2YvoHPukvU4J8odiqNhCkDfEQsZrsWAmQd3zOHjcpDg41DrV2Sihx/eLY+JWeU8AHizHgVeqPPideIwDaotn/2O1Hez8Uc5UW9fuV18rswFuU6MnExxHOmo=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3580.namprd12.prod.outlook.com (2603:10b6:5:11e::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.17; Thu, 23 Jul 2020 05:19:05 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66%2]) with mapi id 15.20.3216.021; Thu, 23 Jul 2020
 05:19:05 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/powerplay: add some documentation about memory
 clock
Thread-Topic: [PATCH] drm/amdgpu/powerplay: add some documentation about
 memory clock
Thread-Index: AQHWX39IYyYRuPoCWUat8mADHbKAkqkUon6w
Date: Thu, 23 Jul 2020 05:19:05 +0000
Message-ID: <DM6PR12MB2619C406BEEACDD73945A96BE4760@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20200721165156.296200-1-alexander.deucher@amd.com>
In-Reply-To: <20200721165156.296200-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=9ae7ff53-066d-4dac-8863-825017a71e35;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-07-23T05:18:48Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8c2ae87e-1a25-4870-93a8-08d82ec7eb70
x-ms-traffictypediagnostic: DM6PR12MB3580:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3580500BA3082ECDC377659CE4760@DM6PR12MB3580.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:257;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZEZgOFpA14L0V4CBmZkkr5foiuZFaRkqUCA7MxwCNv7sDwXQ2IUz5lEVkmc7+KBfW140L+FhxqzEqBJYI7OsOV8dAVnTzWpkRKhh5ZheTwOngLt+EX37hRHzYb1r0mVxQToM/m+tK2ft161yUi1Eh8QOA6dRXcevDSklfTchlsimSc+ARmn4OVYman5NSmmETpykiKE224r4bhGrAe/06iwZDWNjKT5QYgJWD5WUxRkmlD+4PzrtV21CYgl1+fB2oahzp6odn7gkLy7v1tnV4oOED1H59LBVq8Uc/TQpEvBFaMG0lXHEW8nglw9XVd/bikCXF5c1H8sNQtgn36gvPI8DDK9Yt+7S0j9XIyxRq5Q=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(136003)(396003)(39860400002)(366004)(376002)(66476007)(66556008)(8936002)(2906002)(66946007)(76116006)(316002)(7696005)(66446008)(71200400001)(64756008)(110136005)(8676002)(53546011)(4326008)(9686003)(55016002)(33656002)(45080400002)(5660300002)(86362001)(52536014)(478600001)(186003)(966005)(83380400001)(6506007)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: U54YcgHymPwDvxvBZdeo/gFwcFpbl+CRH66dCgCr9anaIBFIB3yykr0SAhpBmONbzW1lZC/4zrge245KW/Sc4bagTBY6w6HgSvRkgPTePBKR6ib25lU1xWr03GnWiQXTUKQT3oebb4HKrv+6MBQe7Y3x5pZLJPSwkAkp8KB58pjRo/2wYaMmi1sNJEblgGpxMiY+O8bwINXEn3OjwPFmA92+LdPoIdUMLtFjhUecZRiB2Vkd9WNbNj27bxCOT6vSk+JPvtCO1m45KXM6+k6VA92LQ0/g12LRlBO4NEVlY6L5kj4asoyVpCemc63ZzGjdxhi70538Z9wqR8M4MhDrXRVzuFzvp5WWT91hjcKIRqmNtJgqzy6A4DZ0jEEBvB54gPIdlDtGTXiNJSXNw/Xf9UjG8ztnOrYzAv69hayzkvQm/3T1/ExDDo32oYSWnK/stz8WBM27JO1idAOp8ukPMvHcunKy95tYqaRQar7ae3ng4O+GQnZq4gQnmBQdPhIZ
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c2ae87e-1a25-4870-93a8-08d82ec7eb70
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2020 05:19:05.4449 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FI1F0aU/7WcGE3crmSkAR/QskfyVzEn6Sr+tsCY2PniadUCE3epH0pUSfO12A/3B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3580
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
Sent: Wednesday, July 22, 2020 12:52 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu/powerplay: add some documentation about memory clock

We expose the actual memory controller clock rate in Linux,
not the effective memory clock of the DRAMs.  To translate
it, it follows the following formula:

Clock conversion (Mhz):
HBM: effective_memory_clock = memory_controller_clock * 1
G5:  effective_memory_clock = memory_controller_clock * 1
G6:  effective_memory_clock = memory_controller_clock * 2

DRAM data rate (MT/s):
HBM: effective_memory_clock * 2 = data_rate
G5:  effective_memory_clock * 4 = data_rate
G6:  effective_memory_clock * 8 = data_rate

Bandwidth (MB/s):
data_rate * vram_bit_width / 8 = memory_bandwidth

Some examples:
G5 on RX460:
memory_controller_clock = 1750 Mhz
effective_memory_clock = 1750 Mhz * 1 = 1750 Mhz
data rate = 1750 * 4 = 7000 MT/s
memory_bandwidth = 7000 * 128 bits / 8 = 112000 MB/s

G6 on RX5600:
memory_controller_clock = 900 Mhz
effective_memory_clock = 900 Mhz * 2 = 1800 Mhz
data rate = 1800 * 8 = 14400 MT/s
memory_bandwidth = 14400 * 192 bits / 8 = 345600 MB/s

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 46 ++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
index 20f39aa04fb9..dd05751f6b35 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
@@ -694,6 +694,52 @@ static ssize_t amdgpu_set_pp_table(struct device *dev,
  * in each power level within a power state.  The pp_od_clk_voltage is used for
  * this.
  *
+ * Note that the actual memory controller clock rate are exposed, not
+ * the effective memory clock of the DRAMs. To translate it, use the
+ * following formula:
+ *
+ * Clock conversion (Mhz):
+ *
+ * HBM: effective_memory_clock = memory_controller_clock * 1
+ *
+ * G5: effective_memory_clock = memory_controller_clock * 1
+ *
+ * G6: effective_memory_clock = memory_controller_clock * 2
+ *
+ * DRAM data rate (MT/s):
+ *
+ * HBM: effective_memory_clock * 2 = data_rate
+ *
+ * G5: effective_memory_clock * 4 = data_rate
+ *
+ * G6: effective_memory_clock * 8 = data_rate
+ *
+ * Bandwidth (MB/s):
+ *
+ * data_rate * vram_bit_width / 8 = memory_bandwidth
+ *
+ * Some examples:
+ *
+ * G5 on RX460:
+ *
+ * memory_controller_clock = 1750 Mhz
+ *
+ * effective_memory_clock = 1750 Mhz * 1 = 1750 Mhz
+ *
+ * data rate = 1750 * 4 = 7000 MT/s
+ *
+ * memory_bandwidth = 7000 * 128 bits / 8 = 112000 MB/s
+ *
+ * G6 on RX5700:
+ *
+ * memory_controller_clock = 875 Mhz
+ *
+ * effective_memory_clock = 875 Mhz * 2 = 1750 Mhz
+ *
+ * data rate = 1750 * 8 = 14000 MT/s
+ *
+ * memory_bandwidth = 14000 * 256 bits / 8 = 448000 MB/s
+ *
  * < For Vega10 and previous ASICs >
  *
  * Reading the file will display:
--
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cevan.quan%40amd.com%7C7742fa0e5b484785420a08d82d966809%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637309471335428042&amp;sdata=370ted69cIqzuGSYStyhun%2FSGkknrdP%2FYtqfZETG1mc%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
