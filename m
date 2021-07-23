Return-Path: <SRS0=Den1=MP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A82C4338F
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jul 2021 07:39:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59C4D60E8E
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jul 2021 07:39:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 59C4D60E8E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AAA06E8D2;
	Fri, 23 Jul 2021 07:39:04 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2057.outbound.protection.outlook.com [40.107.101.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B38046E8D2
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jul 2021 07:39:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ksayPcV4myjWHT9V4hkAHOtaDqjDLZFQs8q8hvQFWiSCWwNDK+MoWEiOwKEWQsOPzxvEmRnAxiSgVHcRy6vWiFsseXjD4vJNz1mZz5yU25r+PQH6EEvjIHou1Dh5jwwPH/qGWROYfVQQ/4McZZbXUfvXVNtC2bwL59ES5Zvz6vKbU+hgmgP6pB1+OKeRbU+S2QGTAOl2HcfqtvuX6Xf8r4gOasRKYJc9Ft3iEoxo5dYA0BQKGz+0Ug5JDpKbJW2KxumhSeBVmMH3azHVWw1yWyrIDkoAHyLfdgwbDLcITncuf6aUDTio5nTLjyEAGJsthmTusLgW+uF/9tz9M4+JVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yVZVAUZAr+AH41czo5ViOoIbevGuQmxBcty9n//r/ws=;
 b=EcVPPa88BMCtvhlnGalmHFRMq/Dx+6xoXQzyOGi96qLKL/LztasTu/iBWgjqkXSXdbn99hjOFImCDXM5DR+I4GgxAhyTmxN/GS+jMZUFDXWSAwm0FJLtRNV5M/CAO5UMJQdnYlTuV8FLoydRGuurp2fE3STgn2tD93ri9NB0SYybzQLziiyJjpc/ueq2a/4mEFgPCoAmkj3QbjTI6lbgfcXoxPwtcm5KZg5yizRfsiu86IMe6iXTjk6yK1M5hBKDLcn095e41eZ3ZtLmkN7GPCOdE9jjv1OMBY5mD6X7mCDw4jPclDrGCp8+DQKQcWz3sQjxJf0Ed5db2F53LcWs5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yVZVAUZAr+AH41czo5ViOoIbevGuQmxBcty9n//r/ws=;
 b=oxszhUezkJ5PCiAfQGc+xxkOg2y375goNYdwA3ms1NdLK2RKy15NjkUvMkR9mvOsl6DkLps8x7DLTR9haxDyS3dQ00CSrBhmsYtLps53HLey5L5NLiFTrjKOw4WTOG4S0ofyy3bWIhUTidaKoDZN+2NCvcsDQaWxN9JaqZGvejY=
Received: from BL1PR12MB5349.namprd12.prod.outlook.com (2603:10b6:208:31f::7)
 by BL1PR12MB5253.namprd12.prod.outlook.com (2603:10b6:208:30b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26; Fri, 23 Jul
 2021 07:39:01 +0000
Received: from BL1PR12MB5349.namprd12.prod.outlook.com
 ([fe80::9991:fa53:1b0a:372c]) by BL1PR12MB5349.namprd12.prod.outlook.com
 ([fe80::9991:fa53:1b0a:372c%4]) with mapi id 15.20.4352.025; Fri, 23 Jul 2021
 07:39:00 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amd/pm: restore user customized OD settings
 properly for NV1x
Thread-Topic: [PATCH 1/2] drm/amd/pm: restore user customized OD settings
 properly for NV1x
Thread-Index: AQHXfqio4aRZbaKly0S3Bkf+Qrx1nKtOpKWAgAAGlwCAAAhKAIABbG6AgAAJSACAAAKtwA==
Date: Fri, 23 Jul 2021 07:39:00 +0000
Message-ID: <BL1PR12MB534990905ACF749947BF81FA97E59@BL1PR12MB5349.namprd12.prod.outlook.com>
References: <20210722032046.767094-1-evan.quan@amd.com>
 <b7ded1e9-08ae-212e-7fa4-2f797bbd228e@amd.com>
 <DM6PR12MB261987F64682AB6A0A337A30E4E49@DM6PR12MB2619.namprd12.prod.outlook.com>
 <47ba61d1-d76e-b10f-acb6-fa25bb4c4d44@amd.com>
 <DM6PR12MB2619A8E359A153660B23092EE4E59@DM6PR12MB2619.namprd12.prod.outlook.com>
 <DM6PR12MB2619A913DFA1F73B8FE32532E4E59@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB2619A913DFA1F73B8FE32532E4E59@DM6PR12MB2619.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-07-23T07:38:53Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=e4c948a6-6ddc-400d-9f91-bd67e09e3873;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 76eb2fb1-6492-4296-bf0f-08d94dacf027
x-ms-traffictypediagnostic: BL1PR12MB5253:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL1PR12MB52530AE094F3E2EB9B30DF1897E59@BL1PR12MB5253.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FFyyfa/yP/CDi8AyG4Yaqj+YJeTP6JRQOEadK6U9CEeTLuggxL8TD+eHu2jpc1XWXjprkgzgd/uWNCss08MskP8EDC3/7/zGByfT7QJQqS4guqRdQRwuGCLl4rHC4drBbAHUUTEeEniFy7AwvsZs/7XbfiEUt0Sxe4gVgA35ydvbxlsjhm8bsZIrMzs/9509ZdkBNqSrJ6ktCaNO3f5E+A+psq9Q9XVBZoGKC/8usF9FtXJp4Eup2RMnAK55oJ5p2k/b1ClpVTEPXXs5G/fD5hjwWTPNYEqbLXg3Rd0qYygaQs3ZNguirhEm+nLfcisQbCGPt+yLkk2+4VVJ1A9q7fPSVWjV4Qxfuh7MqjRRo43FB4ANK4plWGgm5P7u92bADFrwj1CwpCJqumisge/YhmuhnocMVFC6QQ2dqgs+ztnOLLvK5UqRaLu0cgdZ4rTzimFX3BTKdy0wqfIm0v02LyWzpcksoBOOAQLCF2l9vPjZW37YUqtob4qs3V6d2kbiB0nrkM+TbAXptjYewfXvvAwPODXDYa7zVfkCbIfeSr5lSfws3+A36IrZddy+PKhGuPS93vvoDSlbk9ZcIYqfG+J+CNzIWKtz9u2m0MBGcaRookIujVZJ9wHmNOhYN+ZwD8aafohmYS/PUJKGd/phu+OnltU16PckPysDmDRyI1GbzYc+G/lv+5Zf9fV36JfbMeQw/45M+6cqIKjwjAPRZQuu9jqZysu5pbyDR3o7f0g=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5349.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(39860400002)(346002)(396003)(366004)(7696005)(6506007)(53546011)(186003)(71200400001)(4326008)(8936002)(8676002)(26005)(52536014)(2906002)(30864003)(76116006)(83380400001)(55016002)(478600001)(316002)(33656002)(5660300002)(110136005)(66446008)(66556008)(64756008)(66946007)(66476007)(122000001)(86362001)(38100700002)(66574015)(9686003)(32563001)(38070700004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b2pwU0hscS9obEpSNjdsNEhhaFF3blVVVzlRcWJtSXRULzZBTEdKdWd6U2Y4?=
 =?utf-8?B?Vkp5aWR2TkQrZkZISmh1YmJ4RVUyQnBCVjhhRmhGUkxKUDhTeEZjTjZRczZl?=
 =?utf-8?B?WnpWNVEyTWVFZlhGbjZ5VHQ4dVZ3NFhzdmQ0czltbkZydGdCOGV3QVVvNHcx?=
 =?utf-8?B?TVJ2bXVSOHBtY2VtMzJYMnVTTE5SL0Z3SjlTRnhiWW1YZ1hWZkZQTEltN0dk?=
 =?utf-8?B?LzkybjBUZmMrL3cxTk9Jdm5HUkNUZWEwSTJNbjdrRXphTjg3Wk1ZYUszUDBH?=
 =?utf-8?B?cHlRS3Z2dVFMWGJrNFk3b3RaMkc4Z3lUeTdlbXZrSHdDWTVmWGtBWnlGdnkw?=
 =?utf-8?B?OS9sclc0VkVvV1FwcTFJN01ucVk4cExGbGZFRm15QnJqd0JocVdCaVdRMjBp?=
 =?utf-8?B?QytVNnlzTmtzVC80VVZNd3ZnbnpScjBBcExmQjBsSnVWSEZrOFdMMVAwS1E3?=
 =?utf-8?B?aE8zbk5BRlp3b05takpIeGZacUxBUjRXdmJKaHFLTjM5SDcwSUQ3VWthUCtl?=
 =?utf-8?B?OG11UlRzQnR6Y3FOd2RaYkdNWXA0V0FiY3laZVdNNFZhMk1DTmJmOUVIL3Ux?=
 =?utf-8?B?eWJYckpPRU9PWkI4ZXNUN05DaWY1eHp2bi9pSmw0SmZjM2JNSlh4MEFRUVZn?=
 =?utf-8?B?dFJFVXdKNzFwd2tDS1BFczJ3OXFmblZxZWtibEkyRENMUDIvam1BWW1hdytX?=
 =?utf-8?B?aFQ0K2g2TUpnRndOVTRsMGxOLytOd0d1UTlldFBnQ1lwbHdKc3NJWi9USTQ0?=
 =?utf-8?B?TUMzQU55cThiMjRzZGlCMDduQ1JVQ3VwaXBZQ2JUOGhWRnc5M3RYZHN2NFBO?=
 =?utf-8?B?TCtsYllKTGhqSENyMHY1R3dSbEhQUUJOTGxiM0VaM1VxMmZKSEZzekNvZ2NK?=
 =?utf-8?B?c1ZobVp4bkNHUnprQUd2dFd0YnVGYkhndzBQNkI1T1VtSEZ5NWVGU1FsdGV6?=
 =?utf-8?B?L3NMakNHNVZFQ3R2UktWT0pXTjgxQWlTc2JVZkVRRDNQSFhWb25RNis5T3ZD?=
 =?utf-8?B?clJsdmU2WUJhWHZhRUhsQTJQVHdtREx3cTRPWlI5akFJNUJVYVZZY2xkYVZn?=
 =?utf-8?B?QmZ2VHNyeUgvdzI3VE5ZTmdIKzc3SC9yclQrUUpXcDQ5R2NRcjRURWI4L3dk?=
 =?utf-8?B?N2E2ak5UWW9hRWd0eGNQdmhnMEgzZldVU3l1czZYNmdORG9meEFsZTFuVFZL?=
 =?utf-8?B?TUpubEU5RWtPQS9mYVVqaTVWNzBRYjlGd2V5ZXVDbUFkUkk5Yks0dFphekRv?=
 =?utf-8?B?STJybTlxWWhhd1o1MjE1MkRKbDJrN3V1QWViMEMvYXYrOVZSODJxeWhtVnVz?=
 =?utf-8?B?dDZoRWprMTZVdEZnMTJYOWRqSmF4dTc1ZlVzSW0zVi9tc294cmJDb3M1Y3FB?=
 =?utf-8?B?YjY1S2Y5K2U1RVVyZFdvWlNkVUpXZHVOeG4za0Z4NUQzVGJYaWhJOStLdTIw?=
 =?utf-8?B?Q2V3OS83QU5BZWhaSGZSQUYwWXFrbGhWdmJ4U3BKTGRPMTlBL3dRd0JNVnI3?=
 =?utf-8?B?b096WEp3K0lQekh2enR0VzRRMU5xRW5VbWhIbEFhWGJhMFYvZHJqY05Ncm5Y?=
 =?utf-8?B?TmMyb0RQdjZjYVZWSHpDaHVvL1hVZ0xMSlpldHpRRlJOcHpmbkFKczBsRWhL?=
 =?utf-8?B?cmUzNyt0KzRpYjhGNUtrZzdwTCt1YXVWbGd1RUtqU1pHdllRaVkxTUlTRzgw?=
 =?utf-8?B?d292UVhLZ1pEaW1mRHd1T05adURDZjJna1RMdXF5NE5VczgydWxYMG9ucmF1?=
 =?utf-8?Q?EOqbnBkk2+jv76TThjgZC4v8JHzmCTkBdplNa20?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76eb2fb1-6492-4296-bf0f-08d94dacf027
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2021 07:39:00.7420 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tNZ+aG7bm6J0Bn+n+XGzUU5oV9teyqokqkDm8brbWWEbfqXzY7dwCN+hRqtK8LUz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5253
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

[Public]

Hi Evan,

In that case, using "od_edit" table for the intermediate table

During commit command, what if it's done like
	1) Copy and update table if od_edit table is different than user_od table
	2) Set the flag to false if od_edit table and boot_od table are different

Then current od settings may always be picked from user_od table and the flag may be used to distinguish if it's boot od settings or custom settings (for restore or other purposes).

Thanks,
Lijo

-----Original Message-----
From: Quan, Evan <Evan.Quan@amd.com> 
Sent: Friday, July 23, 2021 12:51 PM
To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 1/2] drm/amd/pm: restore user customized OD settings properly for NV1x

[AMD Official Use Only]

Hi Lijo,

Sorry, I doubled checked. The implementation of Navi1x is right. 
The original design for "restores to default settings" is a two-step process.
That means for "case PP_OD_COMMIT_DPM_TABLE:" we must distinguish whether it's an usual customized od setting update or just restoring to defaults.
And my current implementation for that is as below. Any comments?

+               if (memcmp(table_context->overdrive_table, table_context->boot_overdrive_table,
+                       sizeof(OverDriveTable_t))) {
+                       smu->user_dpm_profile.committed_od = true;
+                       memcpy(table_context->committed_overdrive_table, table_context->overdrive_table,
+                                       sizeof(OverDriveTable_t));
+               } else {
+                       smu->user_dpm_profile.committed_od = false;
+               }

BR
Evan
> -----Original Message-----
> From: Quan, Evan
> Sent: Friday, July 23, 2021 2:48 PM
> To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: RE: [PATCH 1/2] drm/amd/pm: restore user customized OD 
> settings properly for NV1x
> 
> [AMD Official Use Only]
> 
> 
> 
> > -----Original Message-----
> > From: Lazar, Lijo <Lijo.Lazar@amd.com>
> > Sent: Thursday, July 22, 2021 5:03 PM
> > To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> > Subject: Re: [PATCH 1/2] drm/amd/pm: restore user customized OD 
> > settings properly for NV1x
> >
> >
> >
> > On 7/22/2021 2:03 PM, Quan, Evan wrote:
> > > [AMD Official Use Only]
> > >
> > >
> > >
> > >> -----Original Message-----
> > >> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> > >> Sent: Thursday, July 22, 2021 4:10 PM
> > >> To: Quan, Evan <Evan.Quan@amd.com>; amd-
> gfx@lists.freedesktop.org
> > >> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> > >> Subject: Re: [PATCH 1/2] drm/amd/pm: restore user customized OD 
> > >> settings properly for NV1x
> > >>
> > >>
> > >>
> > >> On 7/22/2021 8:50 AM, Evan Quan wrote:
> > >>> The customized OD settings can be divided into two parts: those 
> > >>> committed ones and non-committed ones.
> > >>>     - For those changes which had been fed to SMU before
> S3/S4/Runpm
> > >>>       suspend kicked, they are committed changes. They should be
> > properly
> > >>>       restored and fed to SMU on S3/S4/Runpm resume.
> > >>>     - For those non-committed changes, they are restored only 
> > >>> without
> > >> feeding
> > >>>       to SMU.
> > >>>
> > >>> Change-Id: Iea7cf7908dfcd919a4d0205e10bff91b1149a440
> > >>> Signed-off-by: Evan Quan <evan.quan@amd.com>
> > >>> ---
> > >>>    drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  8 +++
> > >>>    drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  9 ++++
> > >>>    .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 52
> > >> ++++++++++++++-----
> > >>>    .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 12 +++++
> > >>>    4 files changed, 69 insertions(+), 12 deletions(-)
> > >>>
> > >>> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> > >>> b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> > >>> index 3e89852e4820..8ba53f16d2d9 100644
> > >>> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> > >>> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> > >>> @@ -231,6 +231,7 @@ struct smu_user_dpm_profile {
> > >>>    	uint32_t power_limit;
> > >>>    	uint32_t fan_speed_percent;
> > >>>    	uint32_t flags;
> > >>> +	uint32_t committed_od;
> > >>>
> > >>>    	/* user clock state information */
> > >>>    	uint32_t clk_mask[SMU_CLK_COUNT]; @@ -352,6 +353,7
> @@ struct
> > >>> smu_table_context
> > >>>
> > >>>    	void				*overdrive_table;
> > >>>    	void                            *boot_overdrive_table;
> > >>> +	void				*committed_overdrive_table;
> > >>
> > >> May be rename it to user_overdrive_table - OD table with user settings?
> > > [Quan, Evan] Actually "overdrive_table " is  the 
> > > user_overdrive_table. It
> > contains all the modification including those not committed( the 
> > commit is performed by echo "c" >
> /sys/class/drm/card1/device/pp_od_clk_voltage).
> > > The new member added refers to those user customized but committed
> > only settings. That's why it was named as " committed_overdrive_table".
> > Any good suggestion for the naming?
> >
> > As far as I understand, the problem is overdrive_table can have 
> > intemediary settings as the edit/commit is a two-step process. At 
> > any point we can have user_od_table keep the latest user mode settings.
> > That is true when user restores to default settings also; that time 
> > we can just copy the boot settings back to user_od table and keep 
> > the flag as false indicating that there is no custom settings.
> [Quan, Evan] For now, on Navi1x the "restores to default settings" is 
> also a two-step process. That will make "copy the boot settings back 
> to user_od table and keep the flag as false" tricky. However, it seems 
> that does not fit original design. As per original design, the "restores to default settings"
> should be a one-step process. Let me correct them with new patch 
> series and proceed further discussion then.
> 
> BR
> Evan
> >
> > >>
> > >>>    	uint32_t			gpu_metrics_table_size;
> > >>>    	void				*gpu_metrics_table;
> > >>> @@ -623,6 +625,12 @@ struct pptable_funcs {
> > >>>    				 enum
> PP_OD_DPM_TABLE_COMMAND
> > >> type,
> > >>>    				 long *input, uint32_t size);
> > >>>
> > >>> +	/**
> > >>> +	 * @restore_committed_od_settings: Restore the customized and
> > >> committed
> > >>> +	 *                                 OD settings on S3/S4/Runpm resume.
> > >>> +	 */
> > >>> +	int (*restore_committed_od_settings)(struct smu_context *smu);
> > >>> +
> > >>>    	/**
> > >>>    	 * @get_clock_by_type_with_latency: Get the speed and
> latency
> > >>> of
> > >> a clock
> > >>>    	 *                                  domain.
> > >>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > >>> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > >>> index ebe672142808..5f7d98e99f76 100644
> > >>> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > >>> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > >>> @@ -416,6 +416,15 @@ static void
> > smu_restore_dpm_user_profile(struct
> > >> smu_context *smu)
> > >>>    		}
> > >>>    	}
> > >>>
> > >>> +	/* Restore customized and committed OD settings */
> > >>> +	if (smu->user_dpm_profile.committed_od) {
> > >>> +		if (smu->ppt_funcs->restore_committed_od_settings) {
> > >>> +			ret = smu->ppt_funcs-
> > >>> restore_committed_od_settings(smu);
> > >>> +			if (ret)
> > >>> +				dev_err(smu->adev->dev, "Failed to upload
> > >> customized OD settings\n");
> > >>> +		}
> > >>> +	}
> > >>> +
> > >>
> > >> Just thinking if there is a need to handle it ASIC specific. The 
> > >> flags and table pointer are maintained in common structure. So 
> > >> can't we do the restore of user OD settings directly in this 
> > >> common flow instead of having each ASIC to implement the callback?
> > > [Quan, Evan] The OD settings restoring is ASIC specific as it 
> > > performed on
> > OD table and that(OD table) is ASIC specific.
> >
> > I was thinking in terms of final logic that is being done. The below 
> > structures are available in common table context and we have a 
> > common logic to update the table. If there is no custom OD settings 
> > available, we could handle it with the flag.
> >
> > +	struct smu_table_context *table_context = &smu->smu_table;
> > +	void *od_table = table_context->committed_overdrive_table;
> > +	int ret = 0;
> > +
> > +	ret = smu_cmn_update_table(smu, SMU_TABLE_OVERDRIVE, 0,
> > (void *)od_table, true);
> >
> > >>
> > >>>    	/* Disable restore flag */
> > >>>    	smu->user_dpm_profile.flags &=
> > >> ~SMU_DPM_USER_PROFILE_RESTORE;
> > >>>    }
> > >>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> > >>> b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> > >>> index 59ea59acfb00..4752299d7f91 100644
> > >>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> > >>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> > >>> @@ -2296,39 +2296,45 @@ static int
> > >> navi10_set_default_od_settings(struct smu_context *smu)
> > >>>    		(OverDriveTable_t *)smu-
> >smu_table.boot_overdrive_table;
> > >>>    	int ret = 0;
> > >>>
> > >>> -	ret = smu_cmn_update_table(smu, SMU_TABLE_OVERDRIVE, 0,
> > >> (void *)od_table, false);
> > >>> +	ret = smu_cmn_update_table(smu, SMU_TABLE_OVERDRIVE, 0,
> > >> (void
> > >>> +*)boot_od_table, false);
> > >>>    	if (ret) {
> > >>>    		dev_err(smu->adev->dev, "Failed to get overdrive
> table!\n");
> > >>>    		return ret;
> > >>>    	}
> > >>>
> > >>> -	if (!od_table->GfxclkVolt1) {
> > >>> +	if (!boot_od_table->GfxclkVolt1) {
> > >>>    		ret =
> navi10_overdrive_get_gfx_clk_base_voltage(smu,
> > >>> -								&od_table-
> > >>> GfxclkVolt1,
> > >>> -								od_table-
> > >>> GfxclkFreq1);
> > >>> +
> > >> 	&boot_od_table->GfxclkVolt1,
> > >>> +
> > >> 	boot_od_table->GfxclkFreq1);
> > >>>    		if (ret)
> > >>>    			return ret;
> > >>>    	}
> > >>>
> > >>> -	if (!od_table->GfxclkVolt2) {
> > >>> +	if (!boot_od_table->GfxclkVolt2) {
> > >>>    		ret =
> navi10_overdrive_get_gfx_clk_base_voltage(smu,
> > >>> -								&od_table-
> > >>> GfxclkVolt2,
> > >>> -								od_table-
> > >>> GfxclkFreq2);
> > >>> +
> > >> 	&boot_od_table->GfxclkVolt2,
> > >>> +
> > >> 	boot_od_table->GfxclkFreq2);
> > >>>    		if (ret)
> > >>>    			return ret;
> > >>>    	}
> > >>>
> > >>> -	if (!od_table->GfxclkVolt3) {
> > >>> +	if (!boot_od_table->GfxclkVolt3) {
> > >>>    		ret =
> navi10_overdrive_get_gfx_clk_base_voltage(smu,
> > >>> -								&od_table-
> > >>> GfxclkVolt3,
> > >>> -								od_table-
> > >>> GfxclkFreq3);
> > >>> +
> > >> 	&boot_od_table->GfxclkVolt3,
> > >>> +
> > >> 	boot_od_table->GfxclkFreq3);
> > >>>    		if (ret)
> > >>>    			return ret;
> > >>>    	}
> > >>>
> > >>> -	memcpy(boot_od_table, od_table, sizeof(OverDriveTable_t));
> > >>> +	navi10_dump_od_table(smu, boot_od_table);
> > >>>
> > >>> -	navi10_dump_od_table(smu, od_table);
> > >>> +	/*
> > >>> +	 * For S3/S4/Runpm, no need to install boot od table to
> > >> overdrive_table as
> > >>> +	 *   - either they already share the same OD settings on bootup
> > >>> +	 *   - or they have user customized OD settings
> > >>> +	 */
> > >>> +	if (!smu->adev->in_suspend)
> > >>> +		memcpy(od_table, boot_od_table,
> > >> sizeof(OverDriveTable_t));
> > >>>
> > >>>    	return 0;
> > >>>    }
> > >>> @@ -2435,6 +2441,14 @@ static int 
> > >>> navi10_od_edit_dpm_table(struct
> > >> smu_context *smu, enum PP_OD_DPM_TABL
> > >>>    			dev_err(smu->adev->dev, "Failed to import
> > >> overdrive table!\n");
> > >>>    			return ret;
> > >>>    		}
> > >>> +		if (memcmp(table_context->overdrive_table, table_context-
> > >>> boot_overdrive_table,
> > >>> +			sizeof(OverDriveTable_t))) {
> > >>
> > >> Shouldn't this be - compare against the edited settings and last 
> > >> committed settings, overdrive_table vs committed_overdrive_table?
> > >>
> > >> Basically, user_od_table can be initialized with boot_od settings 
> > >> and the flag gives the indication that user_od table is being used or not.
> > >> Before updating, check if the edited table (overdrive_table) and 
> > >> the current user_od table are different, then commit the new table.
> > > [Quan, Evan] Yes, I also considered that. But that cannot handle 
> > > the case
> > below:
> > > 1 user made some customizations  -> 2 the customizations were 
> > > committed -> 3 user restored to default(boot) OD settings(by "echo
> > > 'r'")
> > and committed Although there were some changes between 2 and 3,
> there
> > is actually no real customized changes compared to default(boot) OD
> settings.
> >
> > On restore to default, just copy the boot_table settings to user_od 
> > and keep the flag as false. We are using user_od as the latest user 
> > preferred settings and overdrive_table is only used for intermediate
> updates.
> >
> > The flag decides whether to restore or not, but at any point we can 
> > refer the user_od table to look upon the latest preferred user 
> > settings (default or custom).
> >
> > Thanks,
> > Lijo
> >
> > >>
> > >>> +			smu->user_dpm_profile.committed_od = true;
> > >>> +			memcpy(table_context-
> > >>> committed_overdrive_table, table_context->overdrive_table,
> > >>> +					sizeof(OverDriveTable_t));
> > >>> +		} else {
> > >>> +			smu->user_dpm_profile.committed_od = false;
> > >>> +		}
> > >>>    		break;
> > >>>    	case PP_OD_EDIT_VDDC_CURVE:
> > >>>    		if (!navi10_od_feature_is_supported(od_settings,
> > >>> SMU_11_0_ODCAP_GFXCLK_CURVE)) { @@ -2499,6 +2513,19 @@
> static
> > int
> > >> navi10_od_edit_dpm_table(struct smu_context *smu, enum
> > PP_OD_DPM_TABL
> > >>>    	return ret;
> > >>>    }
> > >>>
> > >>> +static int navi10_restore_committed_od_settings(struct
> > >>> +smu_context
> > >>> +*smu) {
> > >>> +	struct smu_table_context *table_context = &smu->smu_table;
> > >>> +	void *od_table = table_context->committed_overdrive_table;
> > >>> +	int ret = 0;
> > >>> +
> > >>> +	ret = smu_cmn_update_table(smu, SMU_TABLE_OVERDRIVE, 0,
> > >> (void *)od_table, true);
> > >>> +	if (ret)
> > >>> +		dev_err(smu->adev->dev, "Failed to import overdrive
> > >> table!\n");
> > >>> +
> > >>> +	return ret;
> > >>> +}
> > >>
> > >> As mentioned before, not sure if this is needed as callback. Even 
> > >> if, this can be something common for smuv11, there is nothing 
> > >> ASIC specific in this logic, right?
> > > [Quan, Evan] Yes, in patch2 of the series, it was made as a SMUV11
> > common API.
> > >
> > > BR
> > > Evan
> > >>
> > >> Thanks,
> > >> Lijo
> > >>
> > >>>    static int navi10_run_btc(struct smu_context *smu)
> > >>>    {
> > >>>    	int ret = 0;
> > >>> @@ -3262,6 +3289,7 @@ static const struct pptable_funcs
> > >> navi10_ppt_funcs = {
> > >>>    	.set_soft_freq_limited_range =
> > >> smu_v11_0_set_soft_freq_limited_range,
> > >>>    	.set_default_od_settings = navi10_set_default_od_settings,
> > >>>    	.od_edit_dpm_table = navi10_od_edit_dpm_table,
> > >>> +	.restore_committed_od_settings = 
> > >>> +navi10_restore_committed_od_settings,
> > >>>    	.run_btc = navi10_run_btc,
> > >>>    	.set_power_source = smu_v11_0_set_power_source,
> > >>>    	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
> diff --git
> > >>> a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> > >>> b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> > >>> index 0a5d46ac9ccd..28fc3f17c1b1 100644
> > >>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> > >>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> > >>> @@ -422,10 +422,20 @@ int smu_v11_0_init_smc_tables(struct
> > >> smu_context *smu)
> > >>>    			ret = -ENOMEM;
> > >>>    			goto err3_out;
> > >>>    		}
> > >>> +
> > >>> +		smu_table->committed_overdrive_table =
> > >>> +			kzalloc(tables[SMU_TABLE_OVERDRIVE].size,
> > >> GFP_KERNEL);
> > >>> +		if (!smu_table->committed_overdrive_table) {
> > >>> +			ret = -ENOMEM;
> > >>> +			goto err4_out;
> > >>> +		}
> > >>> +
> > >>>    	}
> > >>>
> > >>>    	return 0;
> > >>>
> > >>> +err4_out:
> > >>> +	kfree(smu_table->boot_overdrive_table);
> > >>>    err3_out:
> > >>>    	kfree(smu_table->overdrive_table);
> > >>>    err2_out:
> > >>> @@ -442,12 +452,14 @@ int smu_v11_0_fini_smc_tables(struct
> > >> smu_context *smu)
> > >>>    	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
> > >>>
> > >>>    	kfree(smu_table->gpu_metrics_table);
> > >>> +	kfree(smu_table->committed_overdrive_table);
> > >>>    	kfree(smu_table->boot_overdrive_table);
> > >>>    	kfree(smu_table->overdrive_table);
> > >>>    	kfree(smu_table->max_sustainable_clocks);
> > >>>    	kfree(smu_table->driver_pptable);
> > >>>    	kfree(smu_table->clocks_table);
> > >>>    	smu_table->gpu_metrics_table = NULL;
> > >>> +	smu_table->committed_overdrive_table = NULL;
> > >>>    	smu_table->boot_overdrive_table = NULL;
> > >>>    	smu_table->overdrive_table = NULL;
> > >>>    	smu_table->max_sustainable_clocks = NULL;
> > >>>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
