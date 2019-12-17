Return-Path: <SRS0=JueS=2H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F284C43603
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Dec 2019 10:38:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 287DC2072D
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Dec 2019 10:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="2VRmpcuL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 287DC2072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5CB76E980;
	Tue, 17 Dec 2019 10:38:45 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B82F46E980
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Dec 2019 10:38:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IyVoXmqzs1kmjgAOmmVLucG4wBRpRXWg+4a1sW6X94t92+VLMY+GINB2db7gx/hH059GKyAX5RzNUB8mpQrhXS7aZXJS5I/AaFKNjC20PUd1aHn+TpCXDzYrAzjZbMg8a+7DZsRFjXRU70PA0xpj525Nr0hOChs9/XnKFaqBcNN8bR3907KuLt/y8US3Oz9+RXvaj+R0JLsF5r+fI7gVA1Pb8m/wMFV7/pgBCMZ/QwFe2U7l8TvjRWlM/m8OiAOuEYlcTrbIVSVkhQF0ihtHRTbS0iefH61PUmrSeusPz1e6LXhA0K6qROiep/+4+6SwKWTame+kfn9uuK9B7jHCrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7sX55zl0F1s+a0W3OnK6WToQ9lxiwLJBlZR4r45QMU8=;
 b=elWeW7uGVQbTIFaO2Ej/hQ5KFMATUZ40wMtw6qAzu914ObTBEZWZtaGDAvkC2X2zn1m/UPp51zifIiOhxV9wYbIzoEv3yfKVs95iKzHVUmE9Odwo+DxUNvvDPp+sQIwnldQSbCyGegBzbL8ILol7Fx7/O9O1eZK8+Tl/jh5HlIOBw0xnicG5MNVomFUZH5MtzHhKqL0BGNnNGWMdKFFeB+MLaNr8sd6XNPJLN9kENt5V59n/jPfVhhz9oUb1BOT9rLyJP2HrQIVrvR5K1JSPT9FHC5jgsKhq912NEkw2yRaBeCrHy9A0fsgPQLSJT2c6X0MjUa3QeXmrowN342OCXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7sX55zl0F1s+a0W3OnK6WToQ9lxiwLJBlZR4r45QMU8=;
 b=2VRmpcuL8VjigbIMpbkXQpQuwtdO+SfflNzpt9wjqWcHFIUJkqoG5qrIUqYqPr18Hr+mbbU8Hj5pcISosbrww/ngBjV7En0DBFoNIcuJbxhPkE31gfYR6axDnUyZBlYEMR09tWEYqYGtTG1oUPRQLS1IrebPn9JfgRYPHFEdzUo=
Received: from MN2PR12MB2975.namprd12.prod.outlook.com (20.178.243.142) by
 MN2PR12MB4032.namprd12.prod.outlook.com (10.255.239.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.18; Tue, 17 Dec 2019 10:38:41 +0000
Received: from MN2PR12MB2975.namprd12.prod.outlook.com
 ([fe80::851c:eebf:b936:20fd]) by MN2PR12MB2975.namprd12.prod.outlook.com
 ([fe80::851c:eebf:b936:20fd%4]) with mapi id 15.20.2538.019; Tue, 17 Dec 2019
 10:38:41 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Liu, Monk" <Monk.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: fix KIQ ring test fail in TDR of SRIOV
Thread-Topic: [PATCH 2/2] drm/amdgpu: fix KIQ ring test fail in TDR of SRIOV
Thread-Index: AQHVtMOc1oA62NMNYEC78ER924VxnKe+IrMA
Date: Tue, 17 Dec 2019 10:38:41 +0000
Message-ID: <MN2PR12MB29754A69954D54D87A69AAC98F500@MN2PR12MB2975.namprd12.prod.outlook.com>
References: <1576577994-12874-1-git-send-email-Monk.Liu@amd.com>
 <1576577994-12874-2-git-send-email-Monk.Liu@amd.com>
In-Reply-To: <1576577994-12874-2-git-send-email-Monk.Liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-12-17T10:38:39Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=8f577dfb-2658-4fe3-8be1-000024572b4b;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2019-12-17T10:38:39Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: eb1db59b-a22f-47f9-b340-0000e011b512
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Emily.Deng@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 81f05f73-2229-4aba-25f8-08d782dd48e3
x-ms-traffictypediagnostic: MN2PR12MB4032:|MN2PR12MB4032:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB40324D8A87A47145CB77FF348F500@MN2PR12MB4032.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 02543CD7CD
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(136003)(346002)(39860400002)(366004)(396003)(199004)(189003)(13464003)(6506007)(8676002)(478600001)(81156014)(81166006)(2906002)(26005)(45080400002)(4326008)(71200400001)(64756008)(5660300002)(55016002)(66446008)(66556008)(76116006)(66946007)(66476007)(52536014)(86362001)(9686003)(8936002)(7696005)(316002)(33656002)(186003)(110136005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4032;
 H:MN2PR12MB2975.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nVjdHWJ0fbjvjc5W/m86VSl8XmOR0CwCwirIJ44OS30fVzIgQiUpX7fTsJdMOuMgK3AYJOGcVyjix0dTcL38qW6mtL7IBsh5PCB6Cvy1ooX9xLi5N3ycHhRpP2MvqiZQ2xpc99GQ/kVJD9o8R/bpYPGZrt6Smw1oKzMcQ97l9Zhppu0/GoTFwfWulQnzYcqAPvUGhX/ME+iJWORUJ5wLvJC03dBF7D40uCdz6a19EHczDohGX8UTZL1O8dg54AldHDV99aG1538NnVKky0SfX9PM9Vyb+06SCqmTkistzQotstazVz4nuQ0FPLY20qvdycmC8GwDzlTtYzi+IQTiOPlk39KC8yVCjIZw6ZN2nrirW1XDORPs6ijKt5EXKN14xvYQfEs3BasQrw14nx+pCydEJYTehbvqY5kKYT4u3g9K33fFyzvKHTV9FdcIeQBVpz01qfZxhGTf7iJ2z9a/e+wFK+L/7RZFaXiBwlXeP/cpSju7OfXBXBru0XqAJC84DmUSOVhfEuURDpL6oWDGeTljulJx47dK3nPMo8nR9Bo=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81f05f73-2229-4aba-25f8-08d782dd48e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2019 10:38:41.6524 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YMEeNI4G1JYfngAt6/YSswUSy4EUS1vs/Xv4xzEq9G8OR1fJV08G6C1r3nGSCIFn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4032
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
Cc: "Liu, Monk" <Monk.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Emily Deng <Emily.Deng@amd.com>

>-----Original Message-----
>From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Monk Liu
>Sent: Tuesday, December 17, 2019 6:20 PM
>To: amd-gfx@lists.freedesktop.org
>Cc: Liu, Monk <Monk.Liu@amd.com>
>Subject: [PATCH 2/2] drm/amdgpu: fix KIQ ring test fail in TDR of SRIOV
>
>issues:
>MEC is ruined by the amdkfd_pre_reset after VF FLR done
>
>fix:
>amdkfd_pre_reset() would ruin MEC after hypervisor finished the VF FLR, the
>correct sequence is do amdkfd_pre_reset before VF FLR but there is a limitation
>to block this sequence:
>if we do pre_reset() before VF FLR, it would go KIQ way to do register access and
>stuck there, because KIQ probably won't work by that time (e.g. you already
>made GFX hang)
>
>so the best way right now is to simply remove it.
>
>Signed-off-by: Monk Liu <Monk.Liu@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 --
> 1 file changed, 2 deletions(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>index 605cef6..ae962b9 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>@@ -3672,8 +3672,6 @@ static int amdgpu_device_reset_sriov(struct
>amdgpu_device *adev,
> 	if (r)
> 		return r;
>
>-	amdgpu_amdkfd_pre_reset(adev);
>-
> 	/* Resume IP prior to SMC */
> 	r = amdgpu_device_ip_reinit_early_sriov(adev);
> 	if (r)
>--
>2.7.4
>
>_______________________________________________
>amd-gfx mailing list
>amd-gfx@lists.freedesktop.org
>https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.fre
>edesktop.org%2Fmailman%2Flistinfo%2Famd-
>gfx&amp;data=02%7C01%7CEmily.Deng%40amd.com%7C74408803b49e4f328
>f7708d782daba6c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6
>37121748318124859&amp;sdata=4YbyHwEEGxVLEhuOg%2Frc%2FxdhFRwrdm
>FuZ4vpHx%2FApAE%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
