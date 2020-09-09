Return-Path: <SRS0=5+Vp=CS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 473F3C43461
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Sep 2020 01:54:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE6A6216C4
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Sep 2020 01:54:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hugIR442"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE6A6216C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D0DB6E8F3;
	Wed,  9 Sep 2020 01:54:22 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DBA26E8F3
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Sep 2020 01:54:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NpbB0+Az8/RG0TqUCtwr6jYMuqj9q+dAoaKye0yK+uE1Q2dV4UWk4+5aVEeRhsBxxu0AEgkZSwLNrjZGe5kn6/yTa03TBaqX+UdLSnT9l7UgSKSubtCSfEtZNu4mboWKWfPhqoKCBKEcUtL5YnMEl6Ik7QrArd59t49xDAl7HFAwoEwXpfwatgldwLNIkZiqEbazwGhpNYYgJJv1xRZJJVwYuj0at+aD6x5caH3hYLXng7v9THyI/M//yZ5lKw/MAmp2Pk07vPB+UBXDgS/X45/pIdBqswpUrb8nXR8Az25Qpo1qxnFNU+Uvq64cAB6J+bx0i6OwKnN6rcjerUhEHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H9xJHQ5fLQo6O4BdaPT3QKBfg/fubENhXZfWCLVMQ+U=;
 b=hX2yzhpDETdrAQC4ik1suMY10VrZMB6OK6hwOeK6zjK2isGCBKGQSqzmEIQ1qcQwSlKF7bD2uQ+GYNi94ms52E1GGe35AurIWDznnFPiV9rnGHAwG4Oyw3UXrP6H/Wa5OyMXz+uh1vZDNlLvP0VEmTKvKJlcP9Zn4p7oJjpxyQhc5Zhml7K7VuvnnXeqa2+nVliL+FRHl+icYtCqS0kp0bdP+534CVmcs/bzfos6L3848E+IEK26i36dr5rxva9ZF0tehYk8O6q3BzYzvQcUSg7yE4ExiwH6GOQRKjl32M8d1JXIajtdvORrnp4gRO8TNuQLJbzJshegCTXbo+IU+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H9xJHQ5fLQo6O4BdaPT3QKBfg/fubENhXZfWCLVMQ+U=;
 b=hugIR442RQxWBbPBmKU566UH96pd3yWP0WEME8LxP0tJ0w6sNsNyN8c5PigEUdpAFhzmk0dAkO33LsCRxWx3sBqbQBvgVQowqhSsU4rbRW5EnKvV3VY2bb1ehmp1yxOYBp65BWhZegv5fZfT8MWaHGezN1cNycUmY7fXPC30eKY=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4219.namprd12.prod.outlook.com (2603:10b6:5:217::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.16; Wed, 9 Sep 2020 01:54:19 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3370.016; Wed, 9 Sep 2020
 01:54:18 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Matt Coffin <mcoffin13@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/pm: Account for extra separator characters in
 sysfs interface
Thread-Topic: [PATCH] drm/amdgpu/pm: Account for extra separator characters in
 sysfs interface
Thread-Index: AQHWgjYhFqcSyeQ0T0ekFkS643yPbalfk5Vg
Date: Wed, 9 Sep 2020 01:54:18 +0000
Message-ID: <DM6PR12MB26197CFA234BDBBB955B4A69E4260@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20200903210614.22785-1-mcoffin13@gmail.com>
In-Reply-To: <20200903210614.22785-1-mcoffin13@gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=e7db131a-abcc-4ff5-bf9a-29a645a43d07;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-09-09T01:53:25Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7bdc3a8b-4ec7-428b-1420-08d8546343cb
x-ms-traffictypediagnostic: DM6PR12MB4219:
x-microsoft-antispam-prvs: <DM6PR12MB4219D6FBE085C9069FE794F9E4260@DM6PR12MB4219.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BozQglxVS3d9hmPa0E7sqn5cuiSuIJAYBQkCh+Z/WQcctDnr3/ghjdpm1no+CT17GuZ7kjDOQPkcEvuZdd5ExzThdj2cN36h+kLfv/raj3sIH8MJEM727/RcmhAdftWSBJ9OWUylpfAmgr4bNVPY5dWrlIvHbuxNrsx3V1YZ0w/hFvWh+HfCvt0AQjB1JwFFmdNe1TGW02beJjWAKRVD+Y/l1Rp1MdhyCoQhnKh/A3iv+9yBbSSPpYVOJQ9lqK0sTKAzJPURlYuE5dkxxK25Rf26KPUl+ZUhmYOl7saX60eFpmJZuYfXkZVqkzFOpVTmf1J//bcmdh7PHmDgrSreQo+RPGlrYCJBJWsPRgUhrng=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(346002)(136003)(376002)(366004)(8676002)(15650500001)(33656002)(55016002)(5660300002)(8936002)(9686003)(26005)(966005)(316002)(66446008)(71200400001)(6506007)(86362001)(53546011)(66946007)(76116006)(64756008)(66556008)(45080400002)(66476007)(110136005)(478600001)(7696005)(52536014)(2906002)(186003)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: EmNnuO4dVvrfjwtTt66mvjFPB3iqocFkLMWT9zS6a+vfP3Mzw9N9WzAd28p5RwWUF+dOdVj5X7aiCQxpPHjT3eheilFPvvZVHtfAU+/qLxv9UAtroKb4d2w7mnOgkF6ysd9E3I+ik8Jqq3qoEB/R39IUWV6R5PuOTBFkhMK5ACJev2HVT26cR1DEHACpmomE/MyvRgKs6CvDL4qsMky6c2jakdyc4q9eURXyKcv9SF7+eWT3Jz+Ifj1GvSUBL5yAyafR7SS40nOCsXBsp0420v0PDsAolmlqOG8rySNqsUzh90rl39ltdjtSBHg6+f4w8YfoAezZN+DkBUC2oYKycJAyQhVQV9+4IP/iqx2mGgG/uAveiYbF9D7CjvHsX4hmsCmBtNmoE/s5YjIWtn+X38MaTAc9QBgfdFivy8L9g3TLhiDBcTxj+5ZABRI2Sfw4Aij3FXTXsZ3BYA7fFgbBglR2BC3EtPsKYEtzblx/yDhEEk9WXP7ICEQKIjRtsDOB52b7E60QKgeKM/6lITKP/xn1GZD4HTJqr4rl5l2Yh5fxXoVrf/pidLowhAkzU5Iqqz8lK7gQioZu0sAhR9+VjbYbtzZy196ZkY2rMElZ0LHgFXzTHnfu+onlGi35mdgRFDjjcjo+GpyRQCKhlQliIA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bdc3a8b-4ec7-428b-1420-08d8546343cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2020 01:54:18.7533 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nthr4PfdM1C552S0fSUCJcY/e2WQzvNVK9Ex7eWLkowcl529v5MMV/xTVFhKH32I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4219
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

Thanks. Reviewed-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Matt Coffin
Sent: Friday, September 4, 2020 5:06 AM
To: amd-gfx@lists.freedesktop.org
Cc: Matt Coffin <mcoffin13@gmail.com>
Subject: [PATCH] drm/amdgpu/pm: Account for extra separator characters in sysfs interface

Currently, the the input to the pp_od_clk_voltage sysfs interface has
two adjacent separator characters, i.e. "\n\0", then we try to parse an
argument out of the empty string, whereas we really should just ignore
this case, and treat any number of adjacent separators as one separator
for arguments.

We do this here by simply skipping the argument parsing for all
empy-string arguments.

An example test case would be `echo 's  1 900' > pp_od_clk_voltage`
(note the two spaces after the 's'.

This also solves the issue where the written string ends with both a
newline, and a nul-terminator, '\n\0', as is the case for `echo 's 1
900' > pp_od_clk_voltage` since the recent rebase.

Signed-off-by: Matt Coffin <mcoffin13@gmail.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 65f141c777c2..9ab29c21e458 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -801,6 +801,8 @@ static ssize_t amdgpu_set_pp_od_clk_voltage(struct device *dev,
 while (isspace(*++tmp_str));

 while ((sub_str = strsep(&tmp_str, delimiter)) != NULL) {
+if (strlen(sub_str) == 0)
+continue;
 ret = kstrtol(sub_str, 0, &parameter[parameter_size]);
 if (ret)
 return -EINVAL;
--
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cevan.quan%40amd.com%7Cee0ba53db6a34135168908d8504d3f67%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637347640051630594&amp;sdata=MPjsHvjwbERjeLSsQHWymlnqav1O9XlF8DJoGvJpx%2BM%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
