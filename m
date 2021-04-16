Return-Path: <SRS0=1d99=JN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F6AC433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 15:10:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FAA561001
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 15:10:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FAA561001
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D20F36EBFF;
	Fri, 16 Apr 2021 15:10:54 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 379FA6EBFF
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Apr 2021 15:10:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z/io6I91d1C02Q2V1dEstA27CXtjr+zfOdiK91K11kUUY4XPj19lP9qQsqvpM5IuQiwmhv1+BGizEuMukNKDStu6EtptgKsD+pnmKyTZczQjknV08CZuhGAcyk12yOR8QZRmbUNMIQN140RTTFagSpeZu7esvST6VV0QYGPL8jo22MxAYxnD3BIKOeR3OhCheCKvEtRlxnMDfMnd5BEDy/bEr6V0AQ1aozjlrnDHkjXwq5b4f5LY3eDMf+6D9dnzDTPuAn6UoiFPspsuxEIpIgRk2eAxv0S84v301vMdNym9PeTqavCn7YgYItSVeyF0sXPzolViBs9lo3p/VHm09w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XcD2wRlimAhuiYZe69/6lqvqzLY0qc2SyYpHhZKxPac=;
 b=mnKQ5Z01j8c43EpMCuRwsUPnGlcnY8IuGKF06uZNUFFUA2X3AYHMrxRSV7XMa6l7vxr7wj9sUI4yeXbf3B7sv2xEKMm/yuaCHwF9DB3Qj8cCn8d5pjV7k8rmVS+PztZKjruBR9cfhgJ3vWp3mSKMR4j6XLf5/bQr+SQVz3co6X1Z4Mcp1aEQ+8wSTN8snA5ocgj0KtFngfomCZwXK52k3XypyzAKhYZmyda9PO3cCWPHdbdENJpbtyaFLzdNLD4S1dxfkaQNMXPyXYCdJ/q52T0kkWTMqNE84CrpoK9dwcuFTmBoR4qEPTDUI1wFQF+MH4TTIcSyWvv8HZ1zZJNQ9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XcD2wRlimAhuiYZe69/6lqvqzLY0qc2SyYpHhZKxPac=;
 b=GxnDt+bVoDQTn8CSnwKQfEF54wrZUy7EmerZVSmepVMOPen1MXasFFcZxOIm10BpKvXlKD2Mrp8s7fi7mJPKccd26yiFXfORbIMvA6AYAC9SnwoC8domteEns5L0IBbXLBQHz46Tm/zdPV4X3d+ZG4V2r0B7uhbhjqX/YiqhT7s=
Received: from BN9PR12MB5368.namprd12.prod.outlook.com (2603:10b6:408:105::24)
 by BN9PR12MB5260.namprd12.prod.outlook.com (2603:10b6:408:101::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18; Fri, 16 Apr
 2021 15:10:51 +0000
Received: from BN9PR12MB5368.namprd12.prod.outlook.com
 ([fe80::1ef:6c3d:170c:8328]) by BN9PR12MB5368.namprd12.prod.outlook.com
 ([fe80::1ef:6c3d:170c:8328%6]) with mapi id 15.20.4042.019; Fri, 16 Apr 2021
 15:10:51 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Li, Dennis" <Dennis.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix a error injection failed issue
Thread-Topic: [PATCH] drm/amdgpu: fix a error injection failed issue
Thread-Index: AQHXMs+riDDszKbco0eT7a0HM2yQsKq3Pzig
Date: Fri, 16 Apr 2021 15:10:50 +0000
Message-ID: <BN9PR12MB5368E8E8C33DBEAFD3F2989CFC4C9@BN9PR12MB5368.namprd12.prod.outlook.com>
References: <20210416144902.16434-1-Dennis.Li@amd.com>
In-Reply-To: <20210416144902.16434-1-Dennis.Li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-04-16T15:10:48Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=05e98ec7-db18-48d2-af8d-12c4a206951d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ae86a032-6398-422a-2c7d-08d900e9d297
x-ms-traffictypediagnostic: BN9PR12MB5260:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB526056ACA4DEA2997D651062FC4C9@BN9PR12MB5260.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uUUXh77oxLabMbcWR2QUGc0kUWsyBHiwQxD0RJtktOffTzFr//bEyV6HBRnTYfYWPhkNojONcNdZrKlni1NHwucNhym8/V9Wf6XHxk5CFFz7CgOE3Mls0znkpXZqPg+FpeliWQgRBNRoru8qko3w2VdY5Jji+DhVMUUgu9WJcw+0IaZ7ejjBy3bOoiTgab7vwNbHIWZV7gBYyiCLMrGZvTkGVYRsLIvNlv5In1QxOTwsIAKUJryAS1AqABgmLAes64TMlhHgrQ9gg4F50Uln8ypQW2vJY6nflcBuR31B3Xh1RtSZP58jGzXyvoB1EI5DBaUWLJSUC80ZU+7GT92dc35ZirezbtOi7ObHLwhnirI4s+xSwaF/AibNfhZKeBQWTO/EsgWM8T9UYbNKd6bIsnM9g35cBvr7ZMX6GeCFEPVYptPKuPiF7Ubp68hQEBjEg1r202drhoMOI6DXp7EWJujuNsXl19S0m+3UviFoSimqWGl5Xdy5k2mhGWPlG9DnUN/wNgaGLi7ZH0GmJNqkUjhhLAreWRGDaWUhC2nwTGV0EnD9Z5ZCfW7mirPBjtAMzQTraY2HyW1pHDEK6pZ/4ufyAXF8lr4/9s5xowx5y6s=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5368.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(366004)(39860400002)(396003)(186003)(26005)(86362001)(4326008)(110136005)(55016002)(8676002)(71200400001)(6506007)(53546011)(316002)(83380400001)(52536014)(122000001)(38100700002)(9686003)(2906002)(478600001)(66476007)(76116006)(66556008)(66446008)(64756008)(66946007)(6636002)(7696005)(33656002)(8936002)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?PNYltEI1q95j9bNL/gP9t/tRD/0FpHi+NQLm60ieQqYXKkkN9I16n3N/YBd3?=
 =?us-ascii?Q?aN/Ph6cgBlC8kRDAw2vF+kyU3Nh9Z5ThBhDy3DbnuUEe5kll7FMxDV1zdrZ2?=
 =?us-ascii?Q?Y1T33Mre/IM2vY1Pzm2cfwpCznubl28a+JohDnsK+A15W4blhXm4VsWMSPF4?=
 =?us-ascii?Q?QnaT8rrn58nkhnL6ouMWhQi1JOYjgtOEcZsUJpFSf5JimK7Ox6IEkr3BTZKJ?=
 =?us-ascii?Q?NqOS5YbEURXj/W2H2vMW+ryB4d1m6g3b6YSn1hhKz6dX/cCYMPuWGjsYwPRV?=
 =?us-ascii?Q?WK2XQScSSTbYNpf87ro1bMTBuTxd7G4P3NBXzM3mCs8rKmT5Fwl29eNv+hAP?=
 =?us-ascii?Q?Rxp+DHHwZubpxamAJ3MJTb0CenJTCxp/QYKetd1XAfT2w/ky3Iqx6I3zWjxI?=
 =?us-ascii?Q?akAv9TDrqZ4GoJ9hqmj90Tfodc0Q6ggVDonrl9HyMFXWRIN0MzyAwl66PaMT?=
 =?us-ascii?Q?3gNOs5mTnww4ci/uyXh1fDfoOcZq1evOKHmLdBImsR2LJqIWAIz8Ie/OcMbd?=
 =?us-ascii?Q?WwviLqqgQspQdi0UUdmIB8JUPgHTFqvk5yGgE9s3oZ60bS/juLNw7Np0wH40?=
 =?us-ascii?Q?V2xs09ECAguHl2FBcCw7HFDeekpV5gOCrzfl5+t2TqKuOMG2eGXYkOEBkboh?=
 =?us-ascii?Q?f6ESI+ljitm1+yhJKJLcEmfrtPcQl4/EtTT7EbhkKy/V5lcrCMyscU2qyY0a?=
 =?us-ascii?Q?eDRDvN7RkM9PK7BHmMPrknMhgNk5XEtegrdQqWMpro6c3bzPL5O79U/g3d1W?=
 =?us-ascii?Q?L3Sh2ZHnRZlwmHDH6kMfVwfu1VXSrPruEGnkZ/DjkKWJxlEPaOqsdOC3Tsp2?=
 =?us-ascii?Q?YRHw+IatLesBZOt8mWOZE1+wRJ+gxISoGzzzPfK3Qm+8TghtR/63jtDVY4kY?=
 =?us-ascii?Q?KBL+7PQs8i57bkgmCOBtugQfoQjnv70EuhGBj3wsR1k/oM4DoQN1bohDISnO?=
 =?us-ascii?Q?CYHXSj0MMuZFTMgfCF+AdBXValgQyTGGVloHxQUlop9WXUvk6wZSpxZd8pgN?=
 =?us-ascii?Q?ijgkW2owbBrkk22VpALPokalO5oP1W7kd2+lqxTBxd4RPRgm6Kt6OY79qjx7?=
 =?us-ascii?Q?QhYqyWMOL1CJuVBEK6LARu6ajvp8/4Axkw5TTvosPkqeM2G238yi3Eej8TW/?=
 =?us-ascii?Q?GnNIVWgCrJBKIp/qJWQqkucefXw65zQfgZhBII9YEjVv236ZtM3TQCXOQa++?=
 =?us-ascii?Q?qY8ENkWDJFbj1ht2jyVJbWrLbFBxWCLcQSuBZHMpQnMEAiyBu7xFWERz7rQS?=
 =?us-ascii?Q?2VixTytVOXeKLy+W+qVeFldzWL67SHWhYYPVJhMV3kqU2mAUECQYS8pYTMpE?=
 =?us-ascii?Q?pXJ/JD1IlwmrQ3B8HdhhhzmP?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5368.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae86a032-6398-422a-2c7d-08d900e9d297
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2021 15:10:50.7022 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: idciZWdXg59aiowexddQj69koaeEvxpxedFWtFLNV9lQHS66qdhYdChfd2H7PEpv4y2G+l4Ml6cLgcooaJFZeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5260
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
Cc: "Li, Dennis" <Dennis.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking

-----Original Message-----
From: Dennis Li <Dennis.Li@amd.com> 
Sent: Friday, April 16, 2021 22:49
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
Cc: Li, Dennis <Dennis.Li@amd.com>
Subject: [PATCH] drm/amdgpu: fix a error injection failed issue

because "sscanf(str, "retire_page")" always return 0, if application use the raw data for error injection, it always wrongly falls into "op == 3". Change to use strstr instead.

Signed-off-by: Dennis Li <Dennis.Li@amd.com>

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 38a691a3b600..7438d4e84776 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -221,7 +221,7 @@ static int amdgpu_ras_debugfs_ctrl_parse_data(struct file *f,
 		op = 1;
 	else if (sscanf(str, "inject %32s %8s", block_name, err) == 2)
 		op = 2;
-	else if (sscanf(str, "retire_page") == 0)
+	else if (strstr(str, "retire_page") != NULL)
 		op = 3;
 	else if (str[0] && str[1] && str[2] && str[3])
 		/* ascii string, but commands are not matched. */
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
