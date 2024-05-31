Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06023C25B74
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 03:21:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8092910E09A;
	Fri, 31 May 2024 03:21:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JBdDIeHD";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4703910E09A
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 03:21:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FCj+MXVn8FVRD5rVG9cyuBZ0OjY8X96DL8KaTaixZyQsu08vfWUR9dqIbiGBy6OkF0AMyvSqF3TyAznP8hX3VE+7s6jsgCzul6Cc7szXu0PV3WWS9+mgDG/bpttKBl3aAuLpmmMxTErIoN5GgiT4KOjpATT3bmaUf/EnaZrhKKH82BH3W6anRGENqUBphthez1uvD80nWaHr8bGGP/pPbfgb9S3bf0RWy6Vx2UyXw4Jw2qvlGCgxw/b6Y2Rwi9Wn3F4ozvfowJpgSQ5YrPDh1NIEIwumlxpjSqqdX8NfdN3An7nigtcvTV1hPv9mWZaJex7/fujb5pymmUpgGZyChA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rA+cuamrSy+0x9QyhKMM861SRgvo1nljfhwx0y0AUT0=;
 b=dwwEe6Z0GVzzJya+UFj+nfH+Vu6Kr6WcWWr53lN8sZQx/mIgyxZO4bJkpeROXJMzAudDOZH+yKDWVUkjRIyNJ46QTJdLEn9waCxVhX1QF/jYlgEe7ySe4Q4UBrmh8PCQvQVMgD8QmD30YqmB8ESRNIocnjVbG+hEukdWPKvQCfsSd2IwgK82mGb8fHn5gKA3a9wxgE8Pu0tHCZ4wH5EWJFS5XMvl8vxDLcrE0ZvhV0/XdGOlLi25MJlfqO1zJWOjMCvTcyNNhb/iuLC/ydnTSv75C/Yj0YRGXfveGgiilnB7edSGP//xBg9WBbVPz8vyh2WMGlcNkuANLMRKkSY7mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rA+cuamrSy+0x9QyhKMM861SRgvo1nljfhwx0y0AUT0=;
 b=JBdDIeHD1oNN1HGsE4kIofpCM+FsdkAutvWxj/nFHVCBVC28xQgyjDoVTq6u/yOZPBys3ybrQmJ7WjhOs+u+75ggTCQGPpVxPOpAqyfRMIs+RTr/UY/mWLVahi5dcorRVZRMQrskAoc6TGBywecsOEk49AWtupkYthbMgLMtvvc=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by IA0PR12MB9047.namprd12.prod.outlook.com (2603:10b6:208:402::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Fri, 31 May
 2024 03:20:56 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%7]) with mapi id 15.20.7633.021; Fri, 31 May 2024
 03:20:56 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>, "Kim, Jonathan" <Jonathan.Kim@amd.com>, "Huang,
 Tim" <Tim.Huang@amd.com>
Subject: RE: [PATCH 4/8] amd/amdkfd:fix overflowed constant in the function
 svm_migrate_copy_to_ram
Thread-Topic: [PATCH 4/8] amd/amdkfd:fix overflowed constant in the function
 svm_migrate_copy_to_ram
Thread-Index: AQHaskREgrZcXsePxUuJeQcWq0MdPLGv0f+AgADbbuA=
Date: Fri, 31 May 2024 03:20:56 +0000
Message-ID: <BL1PR12MB5144536A4469F9C67BC49832E3FC2@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20240530034801.2341277-1-jesse.zhang@amd.com>
 <df27390c-d55d-4f71-abf5-c744624cd91f@amd.com>
In-Reply-To: <df27390c-d55d-4f71-abf5-c744624cd91f@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=d3096709-cbd0-4193-981b-f156835badc2;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-31T03:16:51Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|IA0PR12MB9047:EE_
x-ms-office365-filtering-correlation-id: 8de04e0c-9a3e-4c46-6f9a-08dc8120af8d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?M1N1SkZjWlV3V1NnQkEzYXJkc0xwZ293aGJOenlMa2REQi9HbWkvZlFRK1Ev?=
 =?utf-8?B?QVJvUzlrQ1VjeDZPZEJHeXlFc01XS1luWnc4VEcxbzBPdE1xUjl5ZUFNaXdG?=
 =?utf-8?B?Q011ZUF2b0Y3SnBua28yU3JyaGdrd0NESnBDQWQrR2V2OFUxZ3B4YzR0K3Ir?=
 =?utf-8?B?Ly9JdCt6cy82eUZtZkt3QXRlaUtxOGd3T1o4U1dubFYyOWYvV2dXUUkzNWNk?=
 =?utf-8?B?NVd5b3Npc0NLZU5aOUZjb1BuczEzZVl0N0k3VS8rMnMxSnF1UGVFcTJuaGU0?=
 =?utf-8?B?aGs0VENCSlJXcTJOU2NtenkySUdGQWJsSEZQbE11dE9KNWpYMzhiVER3MFpi?=
 =?utf-8?B?OWx5QzZCS3ZlMXFNRVhMbldycTFCN3pHREh2NmV5TG5WWlJad0Z4OVJjMHVZ?=
 =?utf-8?B?NnZvbE9HdXE4R1Q2ZFh2ZTNCSk9XUWZLbEVaMFZINHhYS3lGd2dER1VnZVda?=
 =?utf-8?B?dnIwUTVhakdKZXpiZmtIN1ZPRDRGQ0pXbThyVzh3SVRBa0tIaEErTkpxejY3?=
 =?utf-8?B?clhUaHBjenprTWcrOFozVmNHZTdPVnc0MitPNUpmNk03clk0dndyODZVQk1F?=
 =?utf-8?B?TkNKZUlNaXlCMjA5eXM3ZDdNczFYZlJJWXJVSXRlc0ZoNG5tT0JwaTJ0MEpR?=
 =?utf-8?B?ajkyVW1IcGhoZUozN2twR281UjBoZzY1WWxabm80emNHNXl4TVlIK2NoWUF6?=
 =?utf-8?B?b3RJR3VKZzY0TWJXcVZ3eVhNN2didHdQaDlsMFB6YzRUZURRMGViM2xXQlJ5?=
 =?utf-8?B?Y3JnUkRxaFdiSDdiS1V4ZlJ4YkxiTkhCazJiNVhUbWNBbW9pbHRnNnZMSm02?=
 =?utf-8?B?QTFUWTgyOHF1TkNheTI3M2NkL0dwdmJlRVlhcXRHUURybzVuUW80U1dnbW1m?=
 =?utf-8?B?bW9HdUt3c3RLVHB6ZU1pQ295U2c2SFRBeGlnM1J5ajdUNjhJVzNUN2R2VjlF?=
 =?utf-8?B?bFdoRm9HRG5odmlMeE9nRk1TeVFLdTlzY0RONzBNdklVRzZRbXB6TDAwWWlQ?=
 =?utf-8?B?aklYTUhRMCtlaEFHd2o3a0o0WnNGaW9DcVpnK2ltajhYaHlRRzVLMkt5T2FL?=
 =?utf-8?B?bDJmRVJxQW9mRmx5Z2hvVEowMDVEZHRTUGlZcGFEcUtXdi9EdFlEaFpHamNL?=
 =?utf-8?B?c3pTSHRHR3JXWmE4cWRUaU94WUl0dkVjZmg2cVEzblNUaG05b05BQVRGc3BX?=
 =?utf-8?B?QmI4ZFY0QlluckI2UVplWEJ6emxjN0JjNVdtWE01M1VMaDVPQ0ROZnQ1Nyth?=
 =?utf-8?B?eXhzcWpvZ0UwTTlvbGF1MkRIdTNGakFGc3JSWHd5ZkxkTmFnekVraDFVZnFE?=
 =?utf-8?B?bVk4NGZjNmxlb1h2TE9Jd0paSHVsRDhkU1cwZksrTlc5OFhWd1UxMUlZcUIy?=
 =?utf-8?B?Y2h5QlBRUUJTMEN5d0FRTjdQMVdwY3k4YW5rUkVZZXpBWURQUEpsQjQ2bWhp?=
 =?utf-8?B?RGRYRHZYRkQrZ3hhSS9zaExHT09sdUtFUzlqT2ZtUTQ5a2hmWFM3dWJ6VFhy?=
 =?utf-8?B?bjVCRlMvczZrbDZSVUJlVk84YVFPN1ZicHU4YkRtQmZXQThqWmZVN213QnVh?=
 =?utf-8?B?WWt6ai9KU2U5K2ErS2RIL0syK2poK2JUWnhzZ3pRK1h5Mmw0cXVOUkgxbjd1?=
 =?utf-8?B?QW1ndWY1c0tSczkwZlhzbVZPSEU1ZytLRjVLMEllRExsOFM5Y2dId2VpTTVC?=
 =?utf-8?B?bEs1RVF4bFVZNmJMM1pzNVRHR1JPRmdScC8wcDVidXdCNm9xRnRwRU1CRDJl?=
 =?utf-8?B?dmtoSlZrUVZKU2p5bk1RYlRLcnBqMTNmUzVKK1J2ZXVOZDQ5WGdiSmNodzRJ?=
 =?utf-8?B?WVR6THc2UHV2OEtFUUhoUT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M25zbnNVVWMxNFk3Mi90RlIycHVHbGhQdU45MUNjKzJGb05ET3BCeC9ORkl4?=
 =?utf-8?B?c3Z5VmFJU2RBZzF3dGJmaU42cmE2dng0OHpEVzNBSC9xTnF1RmxPSXBCd3FI?=
 =?utf-8?B?enVSSFZ4R25oTXlucHEyMG1YTW1LUVpaem1OYnhmbWZaTEZpakJHVVBSQ1JD?=
 =?utf-8?B?Rno3anpvamVyQjlwd2VCTUpiRyt3ZTFCWjZFSEY5VjBIdFR0NWFNbVNhWWI2?=
 =?utf-8?B?dWN5cEN3dlNEclFFWTJ0YjBuREkrYTRqcnFaUmVmQjdzTmNXMzh3RE9qOHBH?=
 =?utf-8?B?OU5JNUNYUWk1bE5CWW9lUlJBeDNQUFZZNnBLZkxaWjJ6TnpyRXVyMktRYytx?=
 =?utf-8?B?WGF0bTk3QVg5Z0ZOWTZReENnVWpMUWlhMjRxTTc1RGNDaUxiQUhMcHIzdzll?=
 =?utf-8?B?cjhhTzdsUTBxTWtsTHlLQUY0N0tWNnhJaktGbUdSVnB4WTNZKzJNQW5kUysv?=
 =?utf-8?B?M3JESERRSHl1dno4ajNRbUdZOTVodU1tNXZlT1FIS2p5bDBBL01nUUZQWTg5?=
 =?utf-8?B?WXYwTlJZMm5GNFBOTHVOdE9zb2VtU0lxOWJ5ZmZvaVlkNlJ3SDNMc3lKNWZp?=
 =?utf-8?B?WlJwQnZrem1UbkFNbS9kcTVLbVRUak1waXIyYWErdWpxSGpaeFdicCtCSDhu?=
 =?utf-8?B?YSsrSkUvZ3hxeTYyckhWL2dGaTQyZjBkNnExTkpNN3ZGOFI3bDNUSGdtUWJM?=
 =?utf-8?B?bFozQ09sQXdmdXI1a0N2cEZMdytJY0FpUldaUTBId3l5SkNFYUs3Y3Q3YWU2?=
 =?utf-8?B?cVN0RWZyUWlrSHQ3T3h5MnI3d3UxUW5yTnQyV2xBMU04RkZkelRkdTJOYmY1?=
 =?utf-8?B?NmFEbG9DV2FBcTlMZkR5U1IxWHVidldlOG9KbWpCMVZCOWpWZWt5MWhqeGpm?=
 =?utf-8?B?TU40WjZteS9pR00vY2MvUWFMUyt5T1c0cGFMZjZ4em5wck9OaU9KdG5FM0tW?=
 =?utf-8?B?QVdDNWpTUExWeVNFSm96R0JFYm44Z2tEZW50UTcyeG9mZlcvRHpKNXgvdURk?=
 =?utf-8?B?NXdJR2Y2UEIvNE9yak5TUXZ5SFhaRmZKUkR4Ri9SaXZzeC9QWDdsTW5uaWo1?=
 =?utf-8?B?ajR0S2hhcDJleUQwNFdVUi9NcGIvM1ZyQkQwVmFPc3Q0SjFXZmw4ZnFkY01y?=
 =?utf-8?B?d1NKOWM0Q2JiSnE1aDh3S24wOFZ1eDlWTi82dC9vbXdpY3FxYmh4SnVndU5p?=
 =?utf-8?B?UEFEU2I1MVBDVmkvNzB4a0xGUVJHUWd3dWNVYUxXa0RlZGZvTVVEcDR5OUVY?=
 =?utf-8?B?QmNqb3h4cVFLR2JYSlpOUFZKV2hnbGtvQzBmcTBuYVZ2aHZxUHdtSVAzZ1pS?=
 =?utf-8?B?UlF5Y1lDV1E3dzZ6WlhGRmJwUHVlL1ByaGRIaFhDNFhMUXNjQlBVZTlUczNs?=
 =?utf-8?B?NnNSRFVRQk9JQTZGNis4RjRjc0VZZ0xQWG5ERmpVMDh2VW5kajVHMER2Ymll?=
 =?utf-8?B?TnVvdTRDRThxcnVYbzNBeEp3K21UN2ZWYkFTclhlY3BSOEJuUVE1VlFFdmZh?=
 =?utf-8?B?aXFPbjdoajZnbU5JQU0rcCtjQTJadXV6T1JMVUs3NG1IVGJHek9JVVRJOGR5?=
 =?utf-8?B?SnVQeWZQandjL3Y5aGcxQStBZHd0a1QyQXpsR2JBNDhBeXRrNXlDZndxVVFh?=
 =?utf-8?B?NTRlcnlXQlRsVDcxMDRVS3I5M2ZtNzVERDI0eHFNZmphNU54bWxTY1RxTlhB?=
 =?utf-8?B?Z1FJYThBZVY1cGVnVXJTMWgzemViM0pPanF5NGJRaFBOZ1hqVDNWSlBUaVpM?=
 =?utf-8?B?Syt6VktLbHV5b3lPdE0xTUNPZWFYYzhPdk1jNVptaFVUcVVRcGsvYWNxY3kr?=
 =?utf-8?B?T0pwaVlWdjdRdnNYNEhobldtVFc2dXkzWG1jeEQrZzlmQW9YNm51Yk0xWHJD?=
 =?utf-8?B?Nmkrc29NU1YrYkJDOVUyaHNvV2RVL2NHcU9hWWlDbUlnUmxaQ0VnS3daOWkv?=
 =?utf-8?B?WHB0aVdZUGR5UjdsL3EvNHk2bXhhUWZ6MkJIem16RGp1eEFmL2NrZXVPdkxU?=
 =?utf-8?B?SHVOVE56amJLbjBPdFUzSHY0djNLOHlCYXVjMHZFUlM0WmI0a0RRZXVNZ0tz?=
 =?utf-8?B?WENtbFFyUzRxdXlOV0I4cWRsTzd4NTBJZjFXNDI1SXhPWGxHY28wVnY2MnVT?=
 =?utf-8?Q?END0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8de04e0c-9a3e-4c46-6f9a-08dc8120af8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2024 03:20:56.3446 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a50beHiV26yVOJ6sr5aqeUukcbTD3lthsvrV9g+tYgDDG8XLhz73nNbwHEGIyeUPHqCEvcz+wTl8uaEpJQPqIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9047
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KSGkgQ2hyaXN0aWFuIGFuZCBGZWxpeA0KDQpUaGFua3MgZm9yIHlvdXIgY29tbWVudCwgd2Ug
d2lsbCBpZ25vcmUgdGhlc2Ugc2ltaWxhciBDb3Zlcml0eSB3YXJuaW5ncy4NCg0KUmVnYXJkcw0K
SmVzc2UNCg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogS29lbmlnLCBDaHJp
c3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT4NClNlbnQ6IFRodXJzZGF5LCBNYXkgMzAs
IDIwMjQgMTA6MTEgUE0NClRvOiBaaGFuZywgSmVzc2UoSmllKSA8SmVzc2UuWmhhbmdAYW1kLmNv
bT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpDYzogRGV1Y2hlciwgQWxleGFuZGVy
IDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgS3VlaGxpbmcsIEZlbGl4IDxGZWxpeC5LdWVo
bGluZ0BhbWQuY29tPjsgS2ltLCBKb25hdGhhbiA8Sm9uYXRoYW4uS2ltQGFtZC5jb20+OyBIdWFu
ZywgVGltIDxUaW0uSHVhbmdAYW1kLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0ggNC84XSBhbWQv
YW1ka2ZkOmZpeCBvdmVyZmxvd2VkIGNvbnN0YW50IGluIHRoZSBmdW5jdGlvbiBzdm1fbWlncmF0
ZV9jb3B5X3RvX3JhbQ0KDQoNCg0KQW0gMzAuMDUuMjQgdW0gMDU6NDggc2NocmllYiBKZXNzZSBa
aGFuZzoNCj4gSWYgdGhlIHN2bSBtaWdyYXRpb24gY29weSBtZW1vcnkgZ2FydCBmYWlscyBvciB0
aGUgZG1hIG1hcHBpbmcgcGFnZSBmYWlscyBmb3IgdGhlIGZpcnN0IHRpbWUuDQo+IEJ1dCB0aGUg
dmFyaWFibGUgaSBpcyBzdGlsbCAwLCBhbmQgZXhlY3V0aW5nIGktLSB3aWxsIG92ZXJmbG93Lg0K
Pg0KPiBTaWduZWQtb2ZmLWJ5OiBKZXNzZSBaaGFuZyA8SmVzc2UuWmhhbmdAYW1kLmNvbT4NCj4g
LS0tDQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX21pZ3JhdGUuYyB8IDMgKyst
DQo+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPg0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX21pZ3JhdGUuYw0K
PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9taWdyYXRlLmMNCj4gaW5kZXggOGVl
M2QwN2ZmYmRmLi4zNjIwZWFiZjEzYzcgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1ka2ZkL2tmZF9taWdyYXRlLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRr
ZmQva2ZkX21pZ3JhdGUuYw0KPiBAQCAtNjUwLDkgKzY1MCwxMCBAQCBzdm1fbWlncmF0ZV9jb3B5
X3RvX3JhbShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgc3RydWN0IHN2bV9yYW5nZSAqcHJh
bmdlLA0KPiAgIG91dF9vb206DQo+ICAgICAgIGlmIChyKSB7DQo+ICAgICAgICAgICAgICAgcHJf
ZGVidWcoImZhaWxlZCAlZCBjb3B5IHRvIHJhbVxuIiwgcik7DQo+IC0gICAgICAgICAgICAgd2hp
bGUgKGktLSkgew0KPiArICAgICAgICAgICAgIHdoaWxlIChpKSB7DQo+ICAgICAgICAgICAgICAg
ICAgICAgICBzdm1fbWlncmF0ZV9wdXRfc3lzX3BhZ2UoZHN0W2ldKTsNCj4gICAgICAgICAgICAg
ICAgICAgICAgIG1pZ3JhdGUtPmRzdFtpXSA9IDA7DQo+ICsgICAgICAgICAgICAgICAgICAgICBp
LS07DQoNClRoYXQgbG9va3MgaW5jb3JyZWN0IHRvIG1lLg0KDQoiaSIgaXMgdXN1YWxseSB0aGUg
ZW50cnkgd2hpY2ggZmFpbGVkIGFuZCBkb2Vzbid0IG5lZWQgdG8gY2xlYW51cC4gU28gdXNpbmcg
IndoaWxlIChpLS0tKSAuLi4uIiBpcyBhIHZlcnkgY29tbW9uIGFuZCBjb3JyZWN0IHdheSB0byBj
bGVhbiB0aGluZ3MgdXAuDQoNCldpdGggdGhlIGNvZGUgY2hhbmdlZCBhcyBhYm92ZSAwIGZvciBl
eGFtcGxlIHdvdWxkIG5ldmVyIGJlIGNsZWFuZWQgdXAuDQoNCkNocmlzdGlhbi4NCg0KPiAgICAg
ICAgICAgICAgIH0NCj4gICAgICAgfQ0KPg0KDQo=
