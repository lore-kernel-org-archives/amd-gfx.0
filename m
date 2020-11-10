Return-Path: <SRS0=ErGV=EQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55177C55ABD
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 14:40:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2DB020678
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 14:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="LUNNFkJb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2DB020678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 336AF892C9;
	Tue, 10 Nov 2020 14:40:13 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2083B892AC
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2020 14:40:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NKeoNzKJ55F/o+iEoBG/aA9YSIGzqKd3QF/teXgCiHeJ5Y4GJSqulMTOATUkdALoqnOWgkfLbNSZhFlzMibmzcw32/PydBgi3v6J9dmkSBkbKBxpR1CL1+sr03SegYDOl+T7RRbX2DtVriqaQ9JwaJT71uuiL0lhV3rqjmlrnMs8ZAVzZlZTdIn2iJ0TFThSfHAZWpGFsnOkdE72RNB4yPbtift4VYoMBWEQGElt2ocbfmewdja793YpR+x8p+h94W1g+eq8hGksOlF1BnVNc8fcv148WrW0V/2hc8ry+D8xd3+pj52VrsDqnaQq8iKoPr5KeAlSTOXU9S5p+aIZEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1MWZ8YeHTI+N/uxngY7gU2M32FJF6ZBXVZbOb6Kl/HE=;
 b=a/B9pnWRkjqUnLiOZ6eQy3IB4yQ/5zxrPOAAgFJEBudjRIk3cvF8QK7qkwXFh4i48V97FK6mCUg/KcW/LjT5+WyDn1E/rwt6Wy56KNqEY6yvwLHe4Ew8JMAcHiujMI+w6jTDPSlN2s8mEWA+UtwJHwmtNkWqrBT08pn8E7VNgcvu3LqS5aIYUHGcYQdDHbOwlws3kz/Z6oYMwW4J3ykbhvhyuSipmeVcO+2+766V/p3uUuyf5E1iwa/yxOQisyMRWzznD1jinotqGLbqyQJ4Hk/gshzIrHww/Hcb4tZ9XCvVF5un7NHem+P3SQs18I+ml387Fi9tJZ+FuD0DWmY7PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1MWZ8YeHTI+N/uxngY7gU2M32FJF6ZBXVZbOb6Kl/HE=;
 b=LUNNFkJbBCqy31G5Sp/5yQWa9n8dblB6+kb4Ip/sRWdxliUpW5isQDltl64Y/gkUIBul4QGBtsrU6XQonDP+5u8y2TvjVlyO0NiZsCoMeLIqsZ9Rkbe5UYsvuagoqYi83A9mAaSDMajEhNY1EDckeYpmH442Up0zEAj+anmfzQ0=
Received: from DM6PR12MB4156.namprd12.prod.outlook.com (2603:10b6:5:218::17)
 by DM6PR12MB4300.namprd12.prod.outlook.com (2603:10b6:5:21a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.22; Tue, 10 Nov
 2020 14:40:09 +0000
Received: from DM6PR12MB4156.namprd12.prod.outlook.com
 ([fe80::19f9:681a:99bb:c67f]) by DM6PR12MB4156.namprd12.prod.outlook.com
 ([fe80::19f9:681a:99bb:c67f%7]) with mapi id 15.20.3541.021; Tue, 10 Nov 2020
 14:40:09 +0000
From: "Wu, Hersen" <hersenxs.wu@amd.com>
To: "Vishwakarma, Pratik" <Pratik.Vishwakarma@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/display: Tune fclk for 4K OLED display
Thread-Topic: [PATCH] drm/amd/display: Tune fclk for 4K OLED display
Thread-Index: AQHWtlqj9m/9dh6MSEWQ2nDaV1ckaKnBcfMA
Date: Tue, 10 Nov 2020 14:40:09 +0000
Message-ID: <DM6PR12MB415659F054D5163C2BC58F61FDE90@DM6PR12MB4156.namprd12.prod.outlook.com>
References: <20201109053841.3977814-1-Pratik.Vishwakarma@amd.com>
In-Reply-To: <20201109053841.3977814-1-Pratik.Vishwakarma@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-11-10T14:40:03Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=e773529f-d65d-4e30-8907-00005c410422;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-11-10T14:40:03Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: df33da5a-c26a-4ee0-9855-0000d9ce51ab
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.54.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3306eb52-7455-4191-e903-08d88586861a
x-ms-traffictypediagnostic: DM6PR12MB4300:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB43007B14DDC4668D08D3CEDAFDE90@DM6PR12MB4300.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:758;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0azMnq6uViJ/J/Lw3Yhm5wB0+2fJZroVC0HTXlPKEUnwmeqdD0dTdsxRZrD223Vo825/azLvGo7cPW82ba4uhuOzFADZhVHZlCpiT6haHFoJ6E9W6ClSaCwtjTle+Oo0ZhDSioXSh0VLPk3R7bU/CQic6DoSD3j/ZoOp8YXpDczYJDTBcP5cHAdDcHZyGkYSUwkwGqJplsyJ5hRgqKzEiUUg0fgoH8+qL0VCWhfCCAePZYDIdBsdMX+feUq1YtXa6AyDOk20YmTt+hm7qmOQlFzmVCPgyGHbEPoBvP+K54/wgOHNEdOR8kd76G+9i54sa/zqrzDcfTYD5fO3Pa0nUw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4156.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(39860400002)(136003)(366004)(396003)(5660300002)(66476007)(186003)(53546011)(6506007)(2906002)(316002)(71200400001)(86362001)(66446008)(110136005)(66946007)(52536014)(64756008)(66556008)(76116006)(83380400001)(33656002)(9686003)(8676002)(478600001)(8936002)(55016002)(7696005)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: B8J1v1JjGXzPFn8ZV/T2yIYd5pleVaPbZw7BWiLNqzIUwRhbJl9Y2+1o3w1IfjVcNKIfvAv3RD1mxO8kdWLLYmvNPJLcl6NiBGA4Ln750hPWqEKoNMyIqeSAWEu9ZckWlobOFd2/j6PMeGk9h14LaYUzo+S7FdxOhStoL81PdAKkm3Y5LkhF0sLJi/mDERcdGg6xnq3eBd6ykPde/V5ebhbCOXIaq9G0PdTQ8zLHeSjNTXqRi3GDhzpj12H81dTooKtXhFwZ8YjCodgqdY63bsN7IpzEKrgHU1urz8PefhWv+lXP8smZ5hTeTZsdR12KUsocroOSTbLxxOaPiURgN2mR0a8FXO7DB5nP5gJyjxlL2uoVPacG4mKkZHnYx8F1CuoghwnE3Oc/ZdrSGstU1cHMHrjgqN+Gxrq/32TB1+QRlo1aMovCRnVfBN6tlN8Y2kC09bLMb0fK0HDwLXKPXz6UK/88us2oYdTDCEVZSWIxbDuzV2XtUAmnUGgGPP1ej0HOWhN3ISf15WU/kFg1sfmjHqeU5znNNRpoqCQR6LkFF3H1fvxC+u/nOUIt15e3ZZPu8XHF5CmGmpa+gVjCrCUoB38oxrQpisCs+vEtGGijZV+YhbslIIaUONY9LdJpNpGkHZWXfDdkwf6qRzvD6BcFe0SxYq+T11I0BE8WfnKwoiNi8vSdtsot507LvhgdMNbwNddnQPdfTRnyIEerOrQEzVu4noO5bsGpypkqdI4A/oJzy0zWDR7XE4S3htRsTvfdxS47wcI9wnPj2SKhMB9Smr5u0HIICd8jRmdxVZsBoznmn7Uggw79ksW47hZUR0qdTqy2CNC0XXfdYPJsETcf91MfCTAFxO5n8QpOyeT9RA2Ckz+RuFF3eq8d6TA+L+VVBllzgXee/qnnS20ywA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4156.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3306eb52-7455-4191-e903-08d88586861a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2020 14:40:09.4111 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9CMcO1y/eoMM/WoDwX1kcf6FK5gFIwCNtnTBABz6GGe2kwr+rG7w/poCGnwN/juVgUGlSeGTrm5AbEEgdH6X1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4300
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

Reviewed-by: Hersen Wu <hersenxs.wu@amd.com>


-----Original Message-----
From: Vishwakarma, Pratik <Pratik.Vishwakarma@amd.com> 
Sent: Monday, November 9, 2020 12:39 AM
To: Wu, Hersen <hersenxs.wu@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Vishwakarma, Pratik <Pratik.Vishwakarma@amd.com>
Subject: [PATCH] drm/amd/display: Tune fclk for 4K OLED display

[Why]
On 4K SKU, in DC mode, there is a visible slowness observed on system compared to AC mode.

[How]
Tuning min fclk up by 2% resolved this issue.

Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
---
 .../gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr.c   | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr.c
index 832a43053420..ead009628c48 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr.c
@@ -210,6 +210,7 @@ static void rv1_update_clocks(struct clk_mgr *clk_mgr_base,
 	bool send_request_to_increase = false;
 	bool send_request_to_lower = false;
 	int display_count;
+	int i, clock_factor = 0;
 
 	bool enter_display_off = false;
 
@@ -217,6 +218,12 @@ static void rv1_update_clocks(struct clk_mgr *clk_mgr_base,
 
 	pp_smu = &clk_mgr->pp_smu->rv_funcs;
 
+	for (i = 0; i < context->stream_count; i++) {
+		if (context->streams[i]->timing.h_total > 3840
+			|| context->streams[i]->timing.v_total > 2160)
+			clock_factor = 2;
+	}
+
 	display_count = clk_mgr_helper_get_active_display_cnt(dc, context);
 
 	if (display_count == 0)
@@ -302,7 +309,7 @@ static void rv1_update_clocks(struct clk_mgr *clk_mgr_base,
 						(new_clocks->dcfclk_deep_sleep_khz + 999) / 1000);
 			} else {
 				pp_smu->set_hard_min_fclk_by_freq(&pp_smu->pp_smu,
-						new_clocks->fclk_khz / 1000);
+						((new_clocks->fclk_khz / 1000) * (100 + clock_factor)) / 100);
 				pp_smu->set_hard_min_dcfclk_by_freq(&pp_smu->pp_smu,
 						new_clocks->dcfclk_khz / 1000);
 				pp_smu->set_min_deep_sleep_dcfclk(&pp_smu->pp_smu,
--
2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
