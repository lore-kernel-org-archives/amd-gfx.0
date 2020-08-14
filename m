Return-Path: <SRS0=OT/I=BY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C744C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2020 02:14:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4B4922CAD
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2020 02:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Geo0WZMe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4B4922CAD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B41D96E2CA;
	Fri, 14 Aug 2020 02:14:09 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9B426E2CA
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2020 02:14:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rlvn1a4oW3Jw3UbfgO1ADFD4nX+wKj3Rn4l/fP8CpGOP9lPGzSLAPk7S1VT0n+C/1hLEmFVzEE0vLZ3ZgLUlvkaGJEvMfEgl7FRnB5ZROQ29dmEiYAykjBQ/U1a3qpWr7DIVXQAmwC0Bcb/0oZmLmGUp8BE7mSLWViEMbOdrRzGQC1uH7O7npcdwEX/hwQe0IDo/wt0p4MKYCexLb0/Cmr8ZQss1KdG8AWQ94TQp4Zlw5oMnKaujmJ0dkJD9F5lO/17iqv0PPdfdqXNYxqpUXl6NAfjMjxE3jdo8potuKpQV2BFzXf7vVH4PWR5c+zsNrflFNVm8ijsl3BOXqEG00g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6lcBxSxkiD+NlU5Hs9xW9HSM3SKf1wqUFna5hi1Fa40=;
 b=QHf69prgCxwX3VXFnkSCUJmzLSr4pAVXUnIVQU2z5bQk9uGDRkcW6cAxeZGhGUOw32CHamEG06wcUdDTf4aR37BE5KOi/t4IEKwl0djcOXjsSCbEbpNbz47MYzut4vnnyv9LQLe9onhSrcV2xq5pJZAftCS7BA1T2aopkMk4Lw8N+Xro/TogWjjEq3jNgJlxwZ/X4S6sdXkSttm6Zs8MJTs0hIW1FsRS7f1Vri4KD46fRaHBj8x+AlZVaG7oczYi4ZsTChaF7AT6Fquw3diBWBWUBgH7OKZnsf/02oAp5bLeieGBIZ3sA8uGaG5aRnq750M+4WT2Nt72Lw0+hY2jEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6lcBxSxkiD+NlU5Hs9xW9HSM3SKf1wqUFna5hi1Fa40=;
 b=Geo0WZMe1RaEGDNtdyXkjNqTDVHJCmLvJHyMDB5ctsfeznF0wqfLm0VPP9ItyFlr9K6c9coqiLF5zJ38M2VYfc4VvcN1OG4PPCGsvy4cz8iaL1rQ1S4B+SCHjQCAa3Pcid6hb1BmkafRltapG1ufFLCfhdQYyx81MTVxo4RGK9k=
Received: from DM5PR12MB2533.namprd12.prod.outlook.com (2603:10b6:4:b0::10) by
 DM5PR12MB1372.namprd12.prod.outlook.com (2603:10b6:3:77::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.18; Fri, 14 Aug 2020 02:14:06 +0000
Received: from DM5PR12MB2533.namprd12.prod.outlook.com
 ([fe80::b184:d0e4:c548:df63]) by DM5PR12MB2533.namprd12.prod.outlook.com
 ([fe80::b184:d0e4:c548:df63%7]) with mapi id 15.20.3283.016; Fri, 14 Aug 2020
 02:14:06 +0000
From: "Li, Dennis" <Dennis.Li@amd.com>
To: Matt Coffin <mcoffin13@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Fix incorrect return value in sysfs for
 pp_od_clk_voltage
Thread-Topic: [PATCH] drm/amdgpu: Fix incorrect return value in sysfs for
 pp_od_clk_voltage
Thread-Index: AQHWcdiUosQ2e5Yst0eRqucajdh+Mqk204dQ
Date: Fri, 14 Aug 2020 02:14:06 +0000
Message-ID: <DM5PR12MB2533F63FBEBAB56E2A78268CED400@DM5PR12MB2533.namprd12.prod.outlook.com>
References: <20200814011528.10862-1-mcoffin13@gmail.com>
In-Reply-To: <20200814011528.10862-1-mcoffin13@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-08-14T01:58:25Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=851eb78a-602a-49b6-9d0e-de59c79c6a33;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ca075fc3-f1ee-41c3-503c-08d83ff7b8b7
x-ms-traffictypediagnostic: DM5PR12MB1372:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1372737E2E6335CB56C603C8ED400@DM5PR12MB1372.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EDESqXN8RBLKLyJEfVt/1NZeiykbYemq9fFDWT5DLameHSweKkFt6UO+qbytzChdXpBBjD4SYgk0fKuSfzhM5Jm1vP6xW4tT68nXhkK1sj/0exSrqbVPou1bilKJugMkUbX3nFumLydVdk0Cw8aiBkilXqTOAB3puKlubB4KnQPIfGvS8HHizlcWT30PTvIJLiHmdS0z5Sm7ZQ+RZ7phYIp6jtHQRjs84HsLHBliUW2AIE3qTMAcwkT1p7IZb73/cuQ+0e1kGaz3iHJJvifMBTuZksBrUSKpu7YpReKXXjwOCUq0NrkOfIScj5ylra0NA2K1WpY7CLR0NcZPa7K0ymLojmFmQlDGPnfYpT1HgPk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2533.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(396003)(376002)(346002)(39860400002)(316002)(8936002)(26005)(5660300002)(110136005)(55016002)(52536014)(9686003)(45080400002)(8676002)(186003)(66556008)(53546011)(7696005)(83380400001)(6506007)(33656002)(86362001)(2906002)(76116006)(64756008)(66446008)(66476007)(966005)(4326008)(478600001)(71200400001)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: jA1lhh2kHrVHtlYJR1Qmy0R+MD/RisqkdIxBEPATDNngKIjTYIWa7jWkakUbir+PUi40a/+e26EbYCKugEW8O5iVuywyiU3UHShsA9lvG6mXz2y95yTvpiAn8Te9ENJULsQOS0Dbb6g84EKKepoSlp6tfc4ySW52EXSTqISxUb/t+3pnryCsXbS/yILL8FTrENby+MFRhsJwTFyoaik3XpX5dKgQstSYH0j4fWSjS2wKmnLjwlt8+mgPB0uP3Qo9WdzqDXFekRrK1IeqVRGke+0vE7/lskSUeWE2n2t/IxjkJp/4QzAcDtugeRFKr5khaUO2pFDm/D0j34JM9b4w6pDqHd8LP1E81+iBfeWDbcWnLjmy18moG/GEMsSxS23siMKbzJj9PG3mIAj0lX/MocDaXr2Op1jl9H/spWH8+vyY+U16GcJOovYWgRXMo4lRJNz2aoZr2RQ7hdvKjjnueb8/642yb6ISEhzMG3KUuckfdGAwlymZIPYj9M52cLAEC9x+kflUkQ5FVpNXo7vJjBjFUOHQaijVi7+rkeD4T9iaE0TUYAAwvLoFUYof+VVghdpqsl5C4mTMecATlGLFAVsVtnwzA+w1pSEZDIiWo4vYtK4d3LtNQiYaAHf/ymq1QidtGuFIm2vcfISI4Y9ojQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2533.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca075fc3-f1ee-41c3-503c-08d83ff7b8b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2020 02:14:06.0149 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N5uUZSuA/tNXAvHRp+8sHe4Z29ka8jYh2E5unH9p7pOZc1K158QD166o+WeIWcJG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1372
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
Cc: "Koenig, Christian" <Christian.Koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Hi, Matt,
      With your change, I still could reproduce the following issue:

# echo "s 1 1900" > /sys/class/drm/card0/device/pp_od_clk_voltage
bash: echo: write error: Invalid argument

     I found that it is related the following lines code, could you help double check it?

	while ((sub_str = strsep(&tmp_str, delimiter)) != NULL) {  // sub_str will be empty string
		ret = kstrtol(sub_str, 0, &parameter[parameter_size]);
		if (ret)
			return -EINVAL; // return here
		parameter_size++;

		while (isspace(*tmp_str))
			tmp_str++;
	}

Best Regards
Dennis Li
-----Original Message-----
From: Matt Coffin <mcoffin13@gmail.com> 
Sent: Friday, August 14, 2020 9:15 AM
To: amd-gfx@lists.freedesktop.org
Cc: Koenig, Christian <Christian.Koenig@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Matt Coffin <mcoffin13@gmail.com>
Subject: [PATCH] drm/amdgpu: Fix incorrect return value in sysfs for pp_od_clk_voltage

The changes in edad8312cbbf9a33c86873fc4093664f150dd5c1 introduced an issue with the sysfs interface for pp_od_clk_voltage. It overwrites the return value to 0 when it calls another function, then returns 0. The intended behavior is that a positive return value indicates the number of bytes from the buffer that you processed in that call.

With the 0 return value, clients would submit the same value to be written over and over again, resulting in an infinite loop.

This is resolved by returning the count of bytes read (in this case the whole message), when the desired return is 0 (success).

Fixes: edad8312cbbf ("drm/amdgpu: fix system hang issue during GPU")
Bug: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F1245&amp;data=02%7C01%7CDennis.Li%40amd.com%7C4de8308bf7974ea9e62308d83fef922b%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637329646078379799&amp;sdata=N9c6e7cUMCDpvBIYUEzxkadJbJdBryXyfhfhb%2BUEwjg%3D&amp;reserved=0
Signed-off-by: Matt Coffin <mcoffin13@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
index 1705e328c6fc..f00c7ed361d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
@@ -937,7 +937,11 @@ static ssize_t amdgpu_set_pp_od_clk_voltage(struct device *dev,
 
 pro_end:
 	up_read(&adev->reset_sem);
-	return ret;
+	if (ret) {
+		return ret;
+	} else {
+		return count;
+	}
 }
 
 static ssize_t amdgpu_get_pp_od_clk_voltage(struct device *dev,
--
2.28.0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
