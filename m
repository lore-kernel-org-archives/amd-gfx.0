Return-Path: <SRS0=+8vs=BO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D78BC433DF
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2020 14:21:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17713208A9
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2020 14:21:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="LbH5l3pG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17713208A9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B898789D7D;
	Tue,  4 Aug 2020 14:21:09 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700065.outbound.protection.outlook.com [40.107.70.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A403D89D67
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Aug 2020 14:21:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JNsqFLZ1pq80O2DK1NjAivAXEjHGLEdpg7v0MlTBfzjbjn1+T1On4oGMD1nANNU+8uef85i5YWL7tOEwm9S68FZjbuWvaJCTXJ8K5kgxOKu5O8zB9SebNZZ/DIVt5NOntywGP7m4LoxcVLL+9C62jJ9o3QfLXYx2FKnvkNRxslpmhbvbpHgepav1t9tyEit3AUWCF0j/YOgbYAOGOhjR+eTtFB/qbY6IQpReVsM+EuxReQxb03DwDS/V+1sZTWHiMn0HUcXXlxGDWWGv3Oc862XUSzTlvrIeFnZhXYQJFGjKvdtpZAmIL6dbu1UVnRh1GnhdZN0uTNroER0pl9gM4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L7rh0Wvesu5f8GtkNLgR7eRn+ssuPXxD1FS2lypUwOg=;
 b=gFhIv06UHGhvV+DZ6iGMFHRubF23d/xhAcQxH6pc751i/PPickRYWni+TEBvyK2ig1k/lhRbT5fuuQiBnqOhdOFKhuFALF97fiwLOhKZYHzx7YhDibC4VwHfxq2sOi/1gTz13kRGV2AVBip0zt2+lOUaYpRKEsxXsNOMxN0BdcKaKkkWkoU8sAyDgHgU182N6PbootxldQy9z6opYeVcispNSEgnL5yH1tUzuCh9ry9ahLK6cDKjCT8BgDektyvwAi4hcPqE+3lFRNqbnOXaK8NJbBEhxNVGLeRypo5j4qRdB7TdX5LaN+AandkOSdSIhIh63bXBkJB2yYI8IKTHUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L7rh0Wvesu5f8GtkNLgR7eRn+ssuPXxD1FS2lypUwOg=;
 b=LbH5l3pGEA9WYm7rc3xG5qLuUqYHQGCtGMu39Uq4AF+KuN9vPv2oE3BewPu9Te7tPszZc7NLukpKcrTCu4hcAs5OhLo9EdEbKb7a3S9wc782uXAoz7hB2Fswpq5PSzJzGzmiK5I8DVaaJaH1Q0NrU6Hj7nu5YC6xdkT7wv1vUUM=
Received: from DM6PR12MB4156.namprd12.prod.outlook.com (2603:10b6:5:218::17)
 by DM6PR12MB2777.namprd12.prod.outlook.com (2603:10b6:5:51::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.20; Tue, 4 Aug
 2020 14:21:07 +0000
Received: from DM6PR12MB4156.namprd12.prod.outlook.com
 ([fe80::7082:21ba:6e45:32ba]) by DM6PR12MB4156.namprd12.prod.outlook.com
 ([fe80::7082:21ba:6e45:32ba%9]) with mapi id 15.20.3239.022; Tue, 4 Aug 2020
 14:21:07 +0000
From: "Wu, Hersen" <hersenxs.wu@amd.com>
To: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Lin, Wayne"
 <Wayne.Lin@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/dc: Read from DP_SINK_COUNT_ESI for DPDC r1.2 or
 higher
Thread-Topic: [PATCH] drm/amd/dc: Read from DP_SINK_COUNT_ESI for DPDC r1.2 or
 higher
Thread-Index: AQHWahGbzV42ZF8lxEuBv+vG0vjXkKkn+bSAgAAHDuA=
Date: Tue, 4 Aug 2020 14:21:07 +0000
Message-ID: <DM6PR12MB41561296553FE4EEAF8E2CFAFD4A0@DM6PR12MB4156.namprd12.prod.outlook.com>
References: <20200804034218.612-1-Wayne.Lin@amd.com>
 <a7b841e16e781f433f8f68a5e957232357bd71fb.camel@amd.com>
In-Reply-To: <a7b841e16e781f433f8f68a5e957232357bd71fb.camel@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-08-04T14:21:03Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=a983cdc4-9ab5-482b-b5c4-0000fdae5a2a;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-08-04T14:21:03Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 1ff0b172-a5b4-45a6-b982-0000b835b222
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.54.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 63e6b974-2ef3-455e-85cd-08d83881a0ba
x-ms-traffictypediagnostic: DM6PR12MB2777:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB2777EC2917ECE799A43A5DCFFD4A0@DM6PR12MB2777.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IhQqLF0QSCbU8Tjifhe84RZ0vpDqn3qUqX7Q3DMKKc5u6y7u+57ewSdNnAoZNbrzRAnbqYXGlQlySJGylhg1uCUnNQmCVStIWKWblZREiAd+YZPhHxZ+kxro9o1MqWzWRucE9sBuNJSmLjjA3/tajpvIWNKC4Od/SoHNk2ukQjyCCeDu26M5FNDT4PeHaR6ch9fqU9Ad+j+5VmyKsPNAGrSBlqkkfnuBNYkDJIq9nYH5G/iFIFAIWcIXKPWcrN/S270yC4Snp80q5Xtmx6ce9dXBa0ZX1vwGZICVS2xLwcxSrtwLKanCZo013/iCtSar1bEw/QJgKj5bE6tYoZGbOg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4156.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(136003)(366004)(39860400002)(396003)(33656002)(26005)(5660300002)(83380400001)(478600001)(186003)(9686003)(86362001)(66446008)(64756008)(66556008)(52536014)(2906002)(4326008)(55016002)(71200400001)(54906003)(110136005)(7696005)(66476007)(6506007)(66946007)(76116006)(8936002)(8676002)(53546011)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: t66Vx69EK8AAHH97VEYR3ipZE9tRlO1X9T6SGucqQM6ixndx6GF5W42aXNmmluqwbiqH0ioSBUxQduorND3aCMBrfaw2NjHoajzsPb7YnCEH2sB5biHyGxUF6DaYs0qboQoWizY/N9i4GHMpk21yuMXsfYb/pv3QdhhBnVi5k9RZFLKf90oL05jqjYF4+sRfblpxcCKJOVBtiYRhEeyxtPvk77Q67S+CdnDkn1lIe7H83hW+tvB4p+EHaBk1EvsvkDP03MrUxvg3N95O+oYEag8XjyA8tLKqa+eCf9JErnNEpaHyxB1PqKOmZmjMwfvuIwdI5yku/CJXwCgRYRPlkQVC3GTuIymSLH62aTp3Jgm9xHgdEqdTwxUpVUA0FMMQnKNFbPjr5+g+92nFWY8Le5x4eXMY2GoS0JDaCSFbcaQSJ2FnKVLDNEN/cYMKLwGfl1BBrqLy1Aka49QhvEDfDWKm/1Oe5rhRT9dP2xQS4BzyCDGcX7zLHfoCcUBKtADJysKp8IP2HcY8YUEK+SzD7VE9wLX81HNxoFrfgnvPneW/lLFgXTx9HXo61azuMK4mV+pSFCDVq5t2jJaSyiCCEBxOcb1n8djR5FX9B5idUMf49NdtIV4mvw4lX4KDzZnvmaSgvtP88/QFIzu1RfIPZg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4156.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63e6b974-2ef3-455e-85cd-08d83881a0ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2020 14:21:07.0474 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p+cwDjqlmGLWcJq37FZF9sv9x2rVhKgq1T6WJQhedhmg86Iv2XCUPNHmRFztb0IE/BnsUdX6yc/tMuawCQspWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2777
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
Cc: "Cheng, Tony" <Tony.Cheng@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>,
 "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>, "Kazlauskas,
 Nicholas" <Nicholas.Kazlauskas@amd.com>, "Liu, Wenjing" <Wenjing.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]



-----Original Message-----
From: Pillai, Aurabindo <Aurabindo.Pillai@amd.com> 
Sent: Tuesday, August 4, 2020 9:56 AM
To: Lin, Wayne <Wayne.Lin@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Wu, Hersen <hersenxs.wu@amd.com>; Kazlauskas, Nicholas <Nicholas.Kazlauskas@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>
Subject: Re: [PATCH] drm/amd/dc: Read from DP_SINK_COUNT_ESI for DPDC r1.2 or higher

On Tue, 2020-08-04 at 11:42 +0800, Wayne Lin wrote:
> [Why]
> According to DP spec, DPRX with DPCD r1.2 or higher shall have the 
> same Link/Sink Device Status field registers at DPCD Addresses 00200h 
> through 00205h to the corresponding DPRX Event Status Indicator 
> registers at DPCD Addresses 02002h through 0200Fh. We now only read 
> from 02002h when DPCD revision number is r1.4 or higher while handling 
> short HPD. Need to correct that.
> 
> [How]
> Set to read from 02002h when DPCD is r1.2 or higher
> 
> Signed-off-by: Wayne Lin <
> Wayne.Lin@amd.com
> >
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> index 2bfa4e35c2cf..9fb1543b4c73 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> @@ -1834,9 +1834,9 @@ static enum dc_status read_hpd_rx_irq_data(
>  	 * fail, so we now explicitly read 6 bytes which is
>  	 * the req from the above mentioned test cases.
>  	 *
> -	 * For DP 1.4 we need to read those from 2002h range.
> +	 * For DPCD r1.2 or higher, we need to read those from 2002h
> range.
>  	 */
> -	if (link->dpcd_caps.dpcd_rev.raw < DPCD_REV_14)
> +	if (link->dpcd_caps.dpcd_rev.raw < DPCD_REV_12)
>  		retval = core_link_read_dpcd(
>  			link,
>  			DP_SINK_COUNT,

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
